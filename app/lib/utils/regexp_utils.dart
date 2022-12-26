class RegexpUtils {

  static String findRequiredFirst(String pattern, String data) {
    RegExpMatch? regExpMatch = RegExp(
        pattern,
        caseSensitive: false,
        multiLine: true
    ).firstMatch(data);

    if(regExpMatch == null) {
      throw Exception();
    }

    return regExpMatch.group(1).toString().trim();
  }
}