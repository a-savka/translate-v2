import 'package:flutter/material.dart';

class TranslationInput extends StatefulWidget {
  final void Function(String text) onTranslate;
  const TranslationInput({
    Key? key,
    required this.onTranslate,
  }) : super(key: key);

  @override
  State<TranslationInput> createState() => TranslationInputState();
}

class TranslationInputState extends State<TranslationInput> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      padding: const EdgeInsets.only(left: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
        border: Border.all(color: const Color(0xFFDBDBDB)),
      ),
      child: TextField(
        controller: _controller,
        onChanged: (value) {
          setState(() {});
        },
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Enter word',
          hintStyle: const TextStyle(color: Color(0xFFCCCCCC)),
          suffixIcon: Padding(
            padding: const EdgeInsets.all(8),
            child: _controller.text.isEmpty
                ? const SizedBox.shrink()
                : GestureDetector(
                    onTap: () {
                      widget.onTranslate(_controller.text);
                      setState(() {
                        _controller.clear();
                      });
                    },
                    child: const Icon(
                      Icons.send,
                      color: Colors.green,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
