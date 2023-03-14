import 'package:flutter/material.dart';
import 'package:translate_1/domain/models/question.model.dart';

enum OptionState {
  correct,
  wrong,
  neutral,
}

class OptionStateConfig {
  final Color color;
  final IconData icon;
  OptionStateConfig({
    required this.color,
    required this.icon,
  });

  factory OptionStateConfig.fromState(OptionState state, BuildContext context) {
    if (state == OptionState.correct) {
      return OptionStateConfig(
        color: Theme.of(context).colorScheme.primary,
        icon: Icons.check,
      );
    } else if (state == OptionState.neutral) {
      return OptionStateConfig(
        color: Theme.of(context).colorScheme.secondary,
        icon: Icons.circle_outlined,
      );
    }
    return OptionStateConfig(
        color: Colors.deepOrange.shade900, icon: Icons.close_outlined);
  }
}

class QuizOptions extends StatelessWidget {
  final Question question;
  final String? selectedText;
  final bool displayAnswer;
  final void Function(String text, bool isValid) onSelect;

  const QuizOptions({
    required this.question,
    required this.selectedText,
    required this.displayAnswer,
    required this.onSelect,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: question.options.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == question.options.length) {
          return const SizedBox(
            height: 60,
          );
        }

        QuizOption option = question.options[index];
        OptionState state = OptionState.neutral;
        if (displayAnswer) {
          if (option.isValid) {
            state = OptionState.correct;
          } else if (option.text == selectedText) {
            state = OptionState.wrong;
          }
        } else {
          if (option.text == selectedText) {
            state = OptionState.correct;
          }
        }

        OptionStateConfig optionConfig = OptionStateConfig.fromState(
          state,
          context,
        );

        return Material(
          child: InkWell(
            onTap: displayAnswer
                ? null
                : () {
                    onSelect(option.text, option.isValid);
                  },
            child: Container(
              margin: const EdgeInsets.fromLTRB(0, 1, 0, 1),
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 15,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Theme.of(context).colorScheme.tertiary.withAlpha(0x50),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Icon(
                      optionConfig.icon,
                      color: optionConfig.color,
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Text(
                    question.options[index].text,
                    style: TextStyle(
                      color: optionConfig.color,
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
