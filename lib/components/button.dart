import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({super.key, required this.text, required this.onPressed});

  final String text;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: ButtonStyle(
            backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.hovered)) {
            return const Color.fromRGBO(70, 129, 244, 0.9);
          } else {
            return const Color.fromRGBO(70, 129, 244, 0.7);
          }
        })),
        onPressed: () => onPressed(),
        child: Text(text));
  }
}
