import 'package:flutter/material.dart';
import 'package:translate_1/domain/models/question.model.dart';
import 'package:translate_1/ui/skill_test/widgets/pill.dart';
import 'package:translate_1/ui/skill_test/widgets/quiz_options.dart';

class QuizWidget extends StatefulWidget {
  final Question question;
  final int currentQuestionNumber;
  final int correctAnswers;
  final int wrongAnswers;
  final int questionCount;
  final void Function(bool isValid, String text) onAnswer;
  const QuizWidget({
    required this.question,
    required this.onAnswer,
    required this.currentQuestionNumber,
    required this.correctAnswers,
    required this.wrongAnswers,
    required this.questionCount,
    Key? key,
  }) : super(key: key);

  @override
  State<QuizWidget> createState() => QuizWidgetState();
}

class QuizWidgetState extends State<QuizWidget> {
  String? selectedOptionText;
  bool isValidSelected = false;
  Question? completedQuestion;
  int completedNumber = 1;

  @override
  Widget build(BuildContext context) {
    final String questionNumber = completedQuestion == null
        ? widget.currentQuestionNumber.toString()
        : completedNumber.toString();

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 50,
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        completedQuestion?.text ?? widget.question.text,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                    Pill(
                      text: '$questionNumber/${widget.questionCount}',
                      color: Colors.grey,
                      icon: Icons.tag,
                    ),
                    Pill(
                      text: widget.correctAnswers.toString(),
                      color: Colors.green.shade800,
                      icon: Icons.check,
                    ),
                    Pill(
                      text: widget.wrongAnswers.toString(),
                      color: Colors.deepOrange.shade900,
                      icon: Icons.close,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: QuizOptions(
                  question: completedQuestion ?? widget.question,
                  selectedText: selectedOptionText,
                  displayAnswer: completedQuestion != null,
                  onSelect: (text, isValid) {
                    setState(() {
                      selectedOptionText = text;
                      isValidSelected = isValid;
                    });
                  },
                ),
              )
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: completedQuestion == null
                ? ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                    ),
                    onPressed: selectedOptionText == null
                        ? null
                        : () {
                            setState(() {
                              completedQuestion = widget.question;
                              completedNumber = widget.currentQuestionNumber;
                            });
                            widget.onAnswer(isValidSelected,
                                widget.question.translation.text);
                          },
                    child: const Text('Send'),
                  )
                : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                    ),
                    onPressed: () {
                      setState(() {
                        completedQuestion = null;
                        selectedOptionText = null;
                      });
                    },
                    child: const Text('OK'),
                  ),
          )
        ],
      ),
    );
  }
}
