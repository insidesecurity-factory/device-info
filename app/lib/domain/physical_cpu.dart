import 'cpu_architecture.dart';
import 'cpu_cache.dart';
import 'cpu_core.dart';
import 'cpu_stat.dart';


class PhysicalCPU {

  final int socketId;
  final String vendorId;
  final String modelName;
  final String? socketType;
  final int minFrequency;
  final int maxFrequency;
  final int currentFrequency;
  final CPUStat stat;
  final double? percentUsage;
  final CPUArchitecture architecture;
  final CPUCache cache;
  final List<String> features;
  List<CPUCore> cores;

  PhysicalCPU(this.socketId, this.vendorId, this.modelName, this.socketType, this.minFrequency,
      this.maxFrequency, this.currentFrequency, this.stat, this.percentUsage,
      this.architecture, this.cache):
    cores = <CPUCore>[ ],
    features = <String>[ ];
}