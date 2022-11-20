enum FinfluencersDateFilter {
  SIX_HOURS,
  TWELVE_HOURS,
  ONE_DAY,
  ONE_WEEK,
  ONE_MONTH
}

extension RangeStart on FinfluencersDateFilter {
  DateTime fromDate() {
    switch (this) {
      case FinfluencersDateFilter.SIX_HOURS:
        return DateTime.now().subtract(Duration(hours: 6));
      case FinfluencersDateFilter.TWELVE_HOURS:
        return DateTime.now().subtract(Duration(hours: 12));
      case FinfluencersDateFilter.ONE_DAY:
        return DateTime.now().subtract(Duration(days: 1));
      case FinfluencersDateFilter.ONE_WEEK:
        return DateTime.now().subtract(Duration(days: 7));
      case FinfluencersDateFilter.ONE_MONTH:
        return DateTime.now().subtract(Duration(days: 31));
    }
  }
}
