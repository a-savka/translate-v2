import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:translate_1/domain/models/translation.model.dart';
import 'package:translate_1/layouts/default_layout.dart';

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
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null || result.count < 1) {
      return;
    }
    final file = File(result.paths.first!);
    final contents = await file.readAsString();
    final json = jsonDecode(contents);
    final translations = Translations.fromJson(
      {'data': json},
    );
    print('Count: ${translations.data.length}');
  }
}
