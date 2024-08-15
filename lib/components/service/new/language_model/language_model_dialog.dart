import 'package:flutter/material.dart';
import 'package:rag_tco/components/service/new/language_model/language_model_table.dart';

class LanguageModelDialog extends StatelessWidget {
  const LanguageModelDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Edit Language Model"),
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.clear),
            ),
          ],
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
                width: 750,
                height: 500,
                child: SingleChildScrollView(
                  child: LanguageModelTable(),
                ))
          ],
        ));
  }
}
