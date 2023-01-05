import 'package:flutter/material.dart';
import 'package:translate_1/domain/models/translation.model.dart';
import 'package:translate_1/domain/services/filesystem.service.dart';
import 'package:translate_1/layouts/default_layout.dart';
import 'package:translate_1/main_di.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: 'Home Page',
      child: Center(
        child: MaterialButton(
          onPressed: () {
            _pickFile();
          },
          color: Colors.green,
          child: const Text(
            'Select file',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  void _pickFile() async {
    final filesystem = getIt.get<FilesystemService>();
    final path = await filesystem.pickFilePath();
    if (path != null) {
      final json = await filesystem.readJsonFile(path);
      if (json != null) {
        final translations = Translations.fromJson(json);
        print('Count: ${translations.data.length}');
      } else {
        print('Empty data');
      }
    } else {
      print('No file selected');
    }
  }
}
