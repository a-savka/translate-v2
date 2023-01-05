import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';

class FilesystemService {
  Future<String?> pickFilePath() async {
    FilePickerResult? picked;
    try {
      picked = await FilePicker.platform.pickFiles(
        allowMultiple: false,
      );
    } catch (_) {
      print('Picking file failed');
    }
    if (picked == null || picked.count < 1) {
      return null;
    }
    return picked.paths.first;
  }

  Future<String> readTextFile(String path) async {
    File file = File(path);
    String contents = await file.readAsString();
    return contents;
  }

  Future<Map<String, dynamic>?> readJsonFile(String path) async {
    final contents = await readTextFile(path);
    if (contents.isEmpty) {
      return null;
    }
    final json = jsonDecode(contents);
    if (json is List) {
      return {'data': json};
    }
    return json;
  }
}
