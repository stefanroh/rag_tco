import 'package:flutter/material.dart';
import 'package:rag_tco/components/service/new/reranker/reranker_table.dart';

class RerankerDialog extends StatelessWidget {
  const RerankerDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Reranker"),
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
                  child: RerankerTable(),
                ))
          ],
        ));
  }
}
