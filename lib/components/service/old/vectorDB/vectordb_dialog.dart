import 'package:flutter/material.dart';
import 'package:rag_tco/components/service/old/vectorDB/vectordb_table.dart';

class VectordbDialog extends StatelessWidget {
  const VectordbDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Vector DB"),
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
                  child: VectordbTable(),
                ))
          ],
        ));
  }
}
