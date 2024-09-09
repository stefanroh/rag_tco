import 'package:flutter/material.dart';
import 'package:rag_tco/components/service/new/architecture_component/architecture_table.dart';

class ArchitectureDialog extends StatelessWidget {
  const ArchitectureDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Architecture Components"),
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
                  child: ArchitectureTable(),
                ))
          ],
        ));
  }
}
