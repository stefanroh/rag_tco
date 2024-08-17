import 'package:flutter/material.dart';
import 'package:rag_tco/components/service/new/preprocessor/preprocessor_table.dart';

class PreprocessorDialog extends StatelessWidget {
  const PreprocessorDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Preprocessor"),
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
                  child: PreprocessorTable(),
                ))
          ],
        ));
  }
}
