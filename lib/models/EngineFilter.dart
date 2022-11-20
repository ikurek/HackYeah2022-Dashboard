enum EngineFilter { SMART, KEY_WORD, AUTHOR }

extension EngineFilterExtension on String {
  EngineFilter toEngineFilter() {
    if (this.toLowerCase() == "Smart search".toLowerCase()) {
      return EngineFilter.SMART;
    } else if (this.toLowerCase() == "Keyword".toLowerCase()) {
      return EngineFilter.KEY_WORD;
    } else {
      return EngineFilter.AUTHOR;
    }
  }
}
