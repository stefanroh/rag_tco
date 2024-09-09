import 'package:flutter/material.dart';
import 'package:rag_tco/components/service/old/language_model/language_model_component_table.dart';
import 'package:rag_tco/data_model/old/rag_component_language_model.dart';

class LanguageModelComponentDialog extends StatelessWidget {
  const LanguageModelComponentDialog({super.key, required this.model});
  final RagComponentLanguageModel model;

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
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 750,
              child: LanguageModelComponentTable(model: model),
            )
          ],
        ));
  }
}
