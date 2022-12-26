import 'cpu_stat.dart';

class CPUCore {

  final int id;
  final int physicalId;
  final bool isPhysical;
  final int minFrequency;
  final int maxFrequency;
  final int currentFrequency;
  final CPUStat stat;
  final double? usagePercent;

  CPUCore(this.id, this.physicalId, this.isPhysical, this.minFrequency,
      this.maxFrequency, this.currentFrequency, this.stat, this.usagePercent);
}