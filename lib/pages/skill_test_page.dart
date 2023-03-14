import 'package:flutter/material.dart';
import 'package:translate_1/layouts/default_layout.dart';
import 'package:translate_1/ui/skill_test/skill_test.widget.dart';

class SkillTestPage extends StatelessWidget {
  const SkillTestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const DefaultLayout(
      title: 'Skill Testing',
      child: SkillTestWidget(),
    );
  }
}
