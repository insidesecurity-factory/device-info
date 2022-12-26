class CPUStat {

  final int user;
  final int nice;
  final int system;
  final int idle;
  final int ioWait;
  final int hardIrq;
  final int softIrq;
  final int steal;
  final int guest;
  final int guestNice;

  CPUStat(this.user, this.nice, this.system, this.idle, this.ioWait,
      this.hardIrq, this.softIrq, this.steal, this.guest, this.guestNice);
}