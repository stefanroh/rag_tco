import 'package:flutter/material.dart';

class MenuTitle extends StatelessWidget {
  const MenuTitle({super.key, required this.textString});

  final String textString;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: const Divider(),
      ),
      Container(
          margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
          child: Text(
            textString,
            style: const TextStyle(fontWeight: FontWeight.bold),
          )),
    ]);
  }
}
