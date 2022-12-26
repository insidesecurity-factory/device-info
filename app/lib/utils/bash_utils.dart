import 'dart:io';

class BashUtils {

  static String? call(String executable, List<String> arguments) {
    ProcessResult processResult = Process.runSync(
        executable, arguments, workingDirectory: '/');
    String result = processResult.stdout.toString().trim();
    if(result.isEmpty) {
      return null;
    }
    return result;
  }

  static String callRequired(String executable, List<String> arguments) {
    ProcessResult processResult = Process.runSync(
      executable, arguments, workingDirectory: '/');
    String result = processResult.stdout.toString().trim();
    if(result.isEmpty) { throw Exception('result.isEmpty: $executable $arguments.join(" ")'); }
    return result;
  }

  static String callRegexRequired(String executable, List<String> arguments, String patternGroup) {
    ProcessResult processResult = Process.runSync(
        executable, arguments, workingDirectory: '/');
    String result = processResult.stdout.toString().trim();
    if(result.isEmpty) { throw Exception('result.isEmpty: $executable $arguments.join(" ")'); }

    RegExpMatch? regExpMatch = RegExp(patternGroup, caseSensitive: false, multiLine: true)
      .firstMatch(result);

    if(regExpMatch == null) {
      throw Exception('Execution results are not match: $patternGroup');
    }

    return regExpMatch.group(1).toString().trim();
  }
}