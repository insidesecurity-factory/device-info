import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import '../domain/cpu_architecture.dart';
import '../domain/cpu_cache.dart';
import '../domain/cpu_core.dart';
import '../domain/cpu_stat.dart';
import '../domain/physical_cpu.dart';
import '../repository/cpu_repository.dart';
import '../utils/async_utils.dart';
import '../utils/bash_utils.dart';
import '../utils/files_utils.dart';


class CpuInfo {

  Future<List<PhysicalCPU>> getPhysicalCPUList(List<PhysicalCPU>? lastPhysicalCPUList) async {

    // String cpuRepositoryAsset = await rootBundle.loadString('assets/cpu.json');
    // Map<String, dynamic> cpuRepository = json.decode(cpuRepositoryAsset.trim())['list'];

    return AsyncUtils

      // Declare Directory object with path
      .existentDirectory('/sys/devices/system/cpu/')

      // Find all cpu folders
      .list(recursive: false, followLinks: true)

      // Only valid folders and symbolic links
      .where((fileSystemEntity) => fileSystemEntity.existsSync())

      // Only CPU format folder name
      .where((fileSystemEntity) => (RegExp(r'^.+?/cpu\d+$').stringMatch(fileSystemEntity.path) != null))

      // As core ids
      .map((fileSystemEntity){
        final RegExpMatch? regExpMatch = RegExp(r'^.+?/cpu(\d+)$').firstMatch(fileSystemEntity.path);
        if(regExpMatch == null) { throw Exception(); }
        final String? coreIdRepresentation = regExpMatch.group(1);
        if(coreIdRepresentation == null) { throw Exception(); }
        return int.parse(coreIdRepresentation);
      })

      // As list
      .toList()

      // Device without cpu?
      .then((coreIds) {
        if(coreIds.isEmpty) { throw Exception(); }
        coreIds.sort(); // Sort by core id
        return coreIds;
      })

      // Create objects
      .then((coreIds) {

        // Physical CPU list
        List<PhysicalCPU> physicalCPUList = <PhysicalCPU>[ ];

        // For each CPU path
        for(final int coreId in coreIds) {

          // Physical CPU id
          final int physicalCPUId = _getPhysicalCPUId(coreId);

          // Create CPU core object
          final CPUCore cpuCore = _getCPUCore(
            coreId,
            (lastPhysicalCPUList != null) ?
              lastPhysicalCPUList[physicalCPUId].cores[coreId].stat :
              null
          );

          // Create CPU object
          final PhysicalCPU physicalCPU;

          // Physical CPU exist?
          if (physicalCPUList.length > physicalCPUId) {

            // Modify physical CPU object with new core
            physicalCPU = physicalCPUList[physicalCPUId];
            physicalCPU.cores.add(cpuCore);
            physicalCPUList[physicalCPUId] = physicalCPU;

          } else {

            // CPU attributes
            final CPUArchitecture cpuArchitecture = CPUArchitecture(
              BashUtils.callRequired("uname", [ "-m" ]),
              int.parse(BashUtils.callRequired("getconf", [ "LONG_BIT" ]))
            );

            // Variable values
            String? socketType;

            // Final values
            final String vendorId = FilesUtils.getStringByRegExpFromFile('/proc/cpuinfo', r'^vendor_id\s*:\s*(.+)$');
            final String modelName = FilesUtils.getStringByRegExpFromFile('/proc/cpuinfo', r'^model\s+name\s*:\s*(.+)$');
            final CPUCache cpuCache = _getCPUCache();
            final List<String> cpuFeatureList = _getPhysicalCPUFeatures(physicalCPUId);
            final CPUStat globalCPUStat = _getCPUGlobalStat();
            final double? cpuUsage = (
              (lastPhysicalCPUList != null) ?
              _getCPUUsage(globalCPUStat, lastPhysicalCPUList[physicalCPUId].stat) :
              null
            );

            // Find CPU into repository for set variable values
            try {
              // CPU cpu = CPURepository().findByCodename('');
              // socketType = cpu.socket;
            } catch(ignored) {
              //
            }

            // Create physical CPU object with first core
            PhysicalCPU physicalCPU = PhysicalCPU(
              physicalCPUId,
              vendorId,
              modelName,
              socketType,
              _getCoreMinFreq(coreId),
              _getCoreMaxFreq(coreId),
              _getCoreCurrentFreq(coreId),
              globalCPUStat,
              cpuUsage,
              cpuArchitecture,
              cpuCache
            );
            physicalCPU.features.addAll(cpuFeatureList);
            physicalCPU.cores.add(cpuCore);
            physicalCPUList.add(physicalCPU);
          }
        }

        return physicalCPUList;
      })

      // Transform iterable to list
      .then((items) => items.toList())

      // Catch any error
      .catchError((error){ throw error; });
  }

  CPUCore _getCPUCore(int coreId, CPUStat? lastCPUStat) {
    final int physicalCoreId = _getPhysicalCoreId(coreId);
    final bool isPhysical = (physicalCoreId == coreId);
    final int minFreq = _getCoreMinFreq(coreId);
    final int maxFreq = _getCoreMaxFreq(coreId);
    final int curFreq = _getCoreCurrentFreq(coreId);
    final CPUStat cpuStat = _getCPUStat(coreId);
    final double? usagePercent = (lastCPUStat != null) ? _getCPUUsage(cpuStat, lastCPUStat) : null;

    return CPUCore(
      coreId, physicalCoreId, isPhysical,
      minFreq, maxFreq, curFreq,
      cpuStat, usagePercent
    );
  }

  int _getPhysicalCPUId(int coreId) {
    return FilesUtils.getIntFromFile('/sys/devices/system/cpu/cpu$coreId/topology/physical_package_id');
  }

  CPUCache _getCPUCache() {
    String? level1Insert = BashUtils.call('getconf', [ 'LEVEL1_ICACHE_SIZE' ]);
    String? level1Data = BashUtils.call('getconf', [ 'LEVEL1_DCACHE_SIZE' ]);
    String? level2 = BashUtils.call('getconf', [ 'LEVEL2_CACHE_SIZE' ]);
    String? level3 = BashUtils.call('getconf', [ 'LEVEL3_CACHE_SIZE' ]);

    return CPUCache(
      (level1Insert != null) ? int.tryParse(level1Insert) : null,
      (level1Data != null) ? int.tryParse(level1Data) : null,
      (level2 != null) ? int.tryParse(level2) : null,
      (level3 != null) ? int.tryParse(level3) : null
    );
  }

  List<String> _getPhysicalCPUFeatures(int cpuId) {
    final String features = FilesUtils.getStringByRegExpFromFile('/proc/cpuinfo', r'^flags\s*:\s*(.+?)$');
    List<String> results = features.split(' ').map((code) => code.toLowerCase().trim()).toList();
    results.sort();
    return results;
  }

  int _getPhysicalCoreId(int coreId) {
    return FilesUtils.getIntFromFile('/sys/devices/system/cpu/cpu$coreId/topology/core_id');
  }

  int _getCoreMinFreq(int coreId) {
    // In kHz: https://www.kernel.org/doc/Documentation/cpu-freq/user-guide.txt
    return FilesUtils.getIntFromFile('/sys/devices/system/cpu/cpu$coreId/cpufreq/cpuinfo_min_freq') * 1000;
  }

  int _getCoreMaxFreq(int coreId) {
    // In kHz: https://www.kernel.org/doc/Documentation/cpu-freq/user-guide.txt
    return FilesUtils.getIntFromFile('/sys/devices/system/cpu/cpu$coreId/cpufreq/cpuinfo_max_freq') * 1000;
  }

  int _getCoreCurrentFreq(int coreId) {
    // In kHz: https://www.kernel.org/doc/Documentation/cpu-freq/user-guide.txt
    return FilesUtils.getIntFromFile('/sys/devices/system/cpu/cpu$coreId/cpufreq/scaling_cur_freq') * 1024;
  }

  CPUStat _getCPUGlobalStat() {
    final File file = File('/proc/stat');
    if(!file.existsSync()) { throw Exception(); }
    String statString = file.readAsStringSync().trim();

    final RegExpMatch? regExpMatch = RegExp(
        '^cpu\\s+(\\d+)\\s+(\\d+)\\s+(\\d+)\\s+(\\d+)\\s+(\\d+)\\s+(\\d+)\\s+(\\d+)\\s+(\\d+)\\s+(\\d+)\\s+(\\d+)\$',
        multiLine: true
    ).firstMatch(statString);
    if(regExpMatch == null) { throw Exception(); }

    return CPUStat(
        int.parse(regExpMatch.group(1)!), // user
        int.parse(regExpMatch.group(2)!), // nice
        int.parse(regExpMatch.group(3)!), // system
        int.parse(regExpMatch.group(4)!), // idle
        int.parse(regExpMatch.group(5)!), // ioWait
        int.parse(regExpMatch.group(6)!), // hardIrq
        int.parse(regExpMatch.group(7)!), // softIrq
        int.parse(regExpMatch.group(8)!), // steal
        int.parse(regExpMatch.group(9)!), // guest
        int.parse(regExpMatch.group(10)!) // guestNice
    );
  }

  CPUStat _getCPUStat(int coreId) {
    final File file = File('/proc/stat');
    if(!file.existsSync()) { throw Exception(); }
    String statString = file.readAsStringSync().trim();

    final RegExpMatch? regExpMatch = RegExp(
        '^cpu$coreId\\s+(\\d+)\\s+(\\d+)\\s+(\\d+)\\s+(\\d+)\\s+(\\d+)\\s+(\\d+)\\s+(\\d+)\\s+(\\d+)\\s+(\\d+)\\s+(\\d+)\$',
        multiLine: true
    ).firstMatch(statString);
    if(regExpMatch == null) { throw Exception(); }

    return CPUStat(
      int.parse(regExpMatch.group(1)!), // user
      int.parse(regExpMatch.group(2)!), // nice
      int.parse(regExpMatch.group(3)!), // system
      int.parse(regExpMatch.group(4)!), // idle
      int.parse(regExpMatch.group(5)!), // ioWait
      int.parse(regExpMatch.group(6)!), // hardIrq
      int.parse(regExpMatch.group(7)!), // softIrq
      int.parse(regExpMatch.group(8)!), // steal
      int.parse(regExpMatch.group(9)!), // guest
      int.parse(regExpMatch.group(10)!) // guestNice
    );
  }

  double _getCPUUsage(CPUStat currentCPUStat, CPUStat lastCPUStat) {
    // https://www.baeldung.com/linux/get-cpu-usage#2-getting-cpu-usage-using-procstat
    // https://www.linuxquestions.org/questions/showthread.php?p=6377566#post6377566
    // https://bugzilla.kernel.org/show_bug.cgi?id=216442
    // https://stackoverflow.com/questions/23367857/accurate-calculation-of-cpu-usage-given-in-percentage-in-linux

    final int prevIdle = lastCPUStat.idle + lastCPUStat.ioWait;
    final int currentIdle = currentCPUStat.idle + currentCPUStat.ioWait;
    final int prevWorking = (
      lastCPUStat.user + lastCPUStat.nice + lastCPUStat.system +
      lastCPUStat.hardIrq + lastCPUStat.softIrq +
      lastCPUStat.steal + lastCPUStat.guest + lastCPUStat.guestNice
    );
    final int currentWorking = (
      currentCPUStat.user + currentCPUStat.nice + currentCPUStat.system +
      currentCPUStat.hardIrq + currentCPUStat.softIrq +
      currentCPUStat.steal + currentCPUStat.guest + currentCPUStat.guestNice
    );

    final int prevTotal = prevIdle + prevWorking;
    final int currentTotal = currentIdle + currentWorking;

    final int totalDifference = currentTotal - prevTotal;
    final int totalIdle = currentIdle - prevIdle;

    final double usage = ((totalDifference - totalIdle) / totalDifference) * 100;

    if(usage < 0.0) {
      return 0.0;
    } else if(usage > 100.0) {
      return 100.0;
    } else {
      return usage;
    }
  }
}
