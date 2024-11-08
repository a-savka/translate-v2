import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:translate_1/domain/models/translation.model.dart';
import 'package:translate_1/domain/services/skill_testing/skill_test_service.dart';
import 'package:translate_1/layouts/default_layout.dart';
import 'package:translate_1/main_di.dart';
import 'package:translate_1/store/app_state.dart';
import 'package:translate_1/store/skill_test/skill_test_actions.dart';
import 'package:translate_1/ui/skill_test/skill_test.widget.dart';

class SkillTestPage extends StatelessWidget {
  const SkillTestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector(
        converter: (Store<AppState> store) => _ViewModel.fromStore(store),
        builder: (context, viewModel) {
          return DefaultLayout(
            title: 'Skill Testing',
            menuItems: [
              MenuItemButton(
                child: const Text('Restart'),
                onPressed: () {
                  viewModel.restart();
                },
              ),
            ],
            child: const SkillTestWidget(),
          );
        });
  }
}

class _ViewModel {
  final void Function() restart;
  _ViewModel({
    required this.restart,
  });

  factory _ViewModel.fromStore(Store<AppState> store) {
    return _ViewModel(
      restart: () {
        final List<Translation>? translations =
            store.state.translationsState.translations;
        if (translations != null) {
          final SkillTestService skillTestService =
              getIt.get<SkillTestService>();
          final questions = skillTestService.buildTest(
            source: translations!,
            count: 30,
          );
          store.dispatch(StartSkillTestAction(questions));
        }
      },
    );
  }
}
