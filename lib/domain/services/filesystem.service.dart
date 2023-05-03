import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';

class FileSystemService {
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

  Future<String?> pickDirectoryPath() async {
    String? picked;
    try {
      picked = await FilePicker.platform.getDirectoryPath();
    } catch (_) {
      print('Picking directory failed');
    }
    return picked;
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

  Future<void> writeTextFile(String path, String body) async {
    File file = File(path);
    await file.writeAsString(body);
  }

  Future<void> writeJsonFile(String path, Map<String, dynamic> contents) async {
    final body = jsonEncode(contents);
    await writeTextFile(path, body);
  }
}
