enum HarmFilter { NONE, HIGH, MEDIUM, LOW }

extension RangeValues on HarmFilter {
  int rangeStart() {
    switch (this) {
      case HarmFilter.NONE:
        return 0;
      case HarmFilter.HIGH:
        return 8;
      case HarmFilter.MEDIUM:
        return 5;
      case HarmFilter.LOW:
        return 0;
    }
  }

  int rangeEnd() {
    switch (this) {
      case HarmFilter.NONE:
        return 10;
      case HarmFilter.HIGH:
        return 10;
      case HarmFilter.MEDIUM:
        return 7;
      case HarmFilter.LOW:
        return 4;
    }
  }
}

extension HarmFilterExtension on String {
  HarmFilter toHarmFilter() {
    if (this.toLowerCase() == "Wysoka szkodliwość".toLowerCase()) {
      return HarmFilter.HIGH;
    } else if (this.toLowerCase() == "Średnia szkodliwość".toLowerCase()) {
      return HarmFilter.MEDIUM;
    } else if (this.toLowerCase() == "Niska szkodliwość".toLowerCase()) {
      return HarmFilter.LOW;
    } else {
      return HarmFilter.NONE;
    }
  }
}
