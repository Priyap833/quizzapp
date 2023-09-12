import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final VoidCallback selectHandler;
  final String answerText;
  final bool isSelected;

  const Answer({
    required this.selectHandler,
    required this.answerText,
    required this.isSelected,
  });
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? Colors.orangeAccent : null,
        ),
        child: Text(answerText),
        onPressed: selectHandler,
      ),
    );
  }
}