import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:translate_1/domain/models/question.model.dart';
import 'package:translate_1/domain/models/translation.model.dart';
import 'package:translate_1/domain/services/skill_testing/skill_test_service.dart';
import 'package:translate_1/main_di.dart';
import 'package:translate_1/store/app_state.dart';
import 'package:translate_1/store/skill_test/skill_test_actions.dart';
import 'package:translate_1/store/skill_test/skill_test_state.dart';
import 'package:translate_1/store/translations/translations_state.dart';
import 'package:translate_1/ui/generic/widgets/data_line.dart';
import 'package:translate_1/ui/skill_test/widgets/quiz_widget.dart';

class SkillTestWidget extends StatelessWidget {
  const SkillTestWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      converter: (Store<AppState> store) => _ViewModel.fromStore(store: store),
      builder: (BuildContext context, _ViewModel viewModel) {
        if (viewModel.status == SkillTestStatus.pending) {
          return _renderPending(context, viewModel);
        } else if (viewModel.status == SkillTestStatus.done) {
          return _renderDone(context, viewModel);
        }

        return _renderTest(context, viewModel);
      },
    );
  }

  Widget _renderPending(BuildContext context, _ViewModel viewModel) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ElevatedButton(
          onPressed: () {
            _startTest(viewModel);
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(50),
            padding: const EdgeInsets.all(10),
          ),
          child: const Text('Start Test'),
        ),
      ),
    );
  }

  Widget _renderDone(BuildContext context, _ViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DataLine(
            caption: 'Total Questions',
            data: viewModel.questionCount.toString(),
          ),
          const SizedBox(height: 10),
          DataLine(
            caption: 'Correct Answers: ',
            data: viewModel.correctAnswers.toString(),
          ),
          const SizedBox(height: 10),
          DataLine(
            caption: 'Wrong Answers: ',
            data: viewModel.wrongAnswers.toString(),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              _startTest(viewModel);
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(50),
              padding: const EdgeInsets.all(10),
            ),
            child: const Text('Start New Test'),
          ),
        ],
      ),
    );
  }

  Widget _renderTest(BuildContext context, _ViewModel viewModel) {
    return QuizWidget(
      question: viewModel.question!,
      onAnswer: (bool isValid) {
        viewModel.onAnswer(isValid);
      },
      currentQuestionNumber: viewModel.currentQuestionNumber,
      correctAnswers: viewModel.correctAnswers,
      wrongAnswers: viewModel.wrongAnswers,
      questionCount: viewModel.questionCount,
    );
  }

  void _startTest(_ViewModel viewModel) {
    if (viewModel.translations != null) {
      final SkillTestService skillTestService = getIt.get<SkillTestService>();
      final questions = skillTestService.buildTest(
        source: viewModel.translations!,
        count: 30,
      );
      viewModel.onStartTest(questions);
    }
  }
}

class _ViewModel {
  final Question? question;
  final SkillTestStatus status;
  final int correctAnswers;
  final int wrongAnswers;
  final int questionCount;
  final int currentQuestionNumber;
  final List<Translation>? translations;
  final void Function(List<Question> questions) onStartTest;
  final void Function(bool isValid) onAnswer;

  _ViewModel({
    required this.question,
    required this.status,
    required this.correctAnswers,
    required this.wrongAnswers,
    required this.questionCount,
    required this.currentQuestionNumber,
    required this.translations,
    required this.onStartTest,
    required this.onAnswer,
  });

  factory _ViewModel.fromStore({required Store<AppState> store}) {
    final SkillTestState state = store.state.skillTestState;
    final TranslationsState translationsState = store.state.translationsState;
    return _ViewModel(
      question: state.currentQuestion,
      status: state.status,
      correctAnswers: state.correctAnswers,
      wrongAnswers: state.wrongAnswers,
      questionCount: state.questionCount,
      currentQuestionNumber: state.currentQuestionNumber,
      translations: translationsState.translations,
      onStartTest: (questions) {
        store.dispatch(StartSkillTestAction(questions));
      },
      onAnswer: (isValid) {
        store.dispatch(SkillTestAnswerAction(isValid));
      },
    );
  }
}
