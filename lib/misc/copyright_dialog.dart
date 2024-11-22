import 'package:flutter/material.dart';

class CopyrightDialog extends StatelessWidget {
  const CopyrightDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Copyright"),
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.clear),
            ),
          ],
        ),
        content: const Text(
            "RAG Kostenkalkulator © 2024 by Stefan Rohde is licensed under CC BY-NC-SA 4.0. \n\nTo view a copy of this license, visit https://creativecommons.org/licenses/by-nc-sa/4.0/"));
  }
}
