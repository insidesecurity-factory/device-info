import 'dart:io';


class FilesUtils{

  static int getIntFromFile(String path) {
    final File file = File(path);
    if(!file.existsSync()) {
      throw Exception('File is not found: $path');
    }
    return int.parse(file.readAsStringSync().trim());
  }

  static String getStringByRegExpFromFile(String path, String patternGroup) {
    // Read file
    final File file = File(path);
    if(!file.existsSync()) {
      throw Exception('File is not found: $path');
    }
    final String content = file.readAsStringSync();

    // Find content
    final RegExpMatch? regExpMatch = RegExp(patternGroup, multiLine: true)
      .firstMatch(content);
    if(regExpMatch == null) {
      throw Exception('Content file is not match: $path -> $patternGroup');
    }

    // Get group
    final String? result = regExpMatch.group(1);
    if(result == null) {
      throw Exception('Content file are not match contents: $path -> $patternGroup');
    }

    return result;
  }
}