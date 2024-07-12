import 'package:flutter/material.dart';

class ToggleItem extends StatefulWidget {
  const ToggleItem({
    super.key,
    required this.itemText,
    required this.onPress,
  });

  final String itemText;
  final void Function(bool newValue) onPress;

  @override
  State<ToggleItem> createState() => _ToggleItemState();
}

class _ToggleItemState extends State<ToggleItem> {
  bool isPressed = true;

  void buttonPressed(bool newValue) {
    setState(() {
      isPressed = newValue;
      widget.onPress(newValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      SizedBox(
        width: 150,
        child: Text(widget.itemText),
      ),
      Switch(
          value: isPressed,
          activeColor: Colors.blue,
          onChanged: (newValue) => buttonPressed(newValue))
    ]);
  }
}
