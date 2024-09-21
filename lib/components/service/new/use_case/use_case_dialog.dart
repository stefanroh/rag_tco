import 'package:flutter/material.dart';
import 'package:rag_tco/components/service/old/use_case/use_case_storage.dart';

class UseCaseDialog extends StatelessWidget{

  const UseCaseDialog({super.key, required this.storage});

  final UseCaseStorage storage;
  
  @override
  Widget build(BuildContext context) {
     return AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Use Case Settings"),
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.clear),
            ),
          ],
        ),
        content: const Text(""));
  }
}