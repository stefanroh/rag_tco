import 'package:flutter/material.dart';
import 'package:rag_tco/components/service/new/storage/storage_table.dart';

class StorageDialog extends StatelessWidget {
  const StorageDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Storage"),
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
                  child: StorageTable(),
                ))
          ],
        ));
  }
}
