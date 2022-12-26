import 'dart:async';
import 'dart:io';


class AsyncUtils {

  static Future<List<Object>> throwIfEmpty(List<Object> list) {
    if(list.isEmpty) {
      throw Exception('List is empty');
    }

    // Return for async
    Completer<List<Object>> completer = Completer<List<Object>>();
    completer.complete(list);
    return completer.future;
  }

  static Directory existentDirectory(String path) {
    Directory directory = Directory(path);
    if(!directory.existsSync()){
      throw Exception('Directory is not found: $path');
    }
    return directory;
  }
}