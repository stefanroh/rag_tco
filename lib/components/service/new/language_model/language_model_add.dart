import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rag_tco/components/button.dart';
import 'package:rag_tco/data_model/old/timeframe_type.dart';
import 'package:rag_tco/misc/provider.dart';

class LanguageModelAdd extends ConsumerStatefulWidget {
  const LanguageModelAdd({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _LanguageModelAddState();
}

class _LanguageModelAddState extends ConsumerState {
  List<TextEditingController> controllerList = [];
  int selectedProviderIndex = 0;
  TimeframeType selectedTimeframe = TimeframeType.day;
  TextEditingController entryNameController = TextEditingController();
  TextEditingController frequencyController = TextEditingController();

  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Add Language Model"),
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
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 3),
                  child: SizedBox(
                    width: 250,
                    child: Text("Name"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: SizedBox(
                    width: 250,
                    child: TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), hintText: "Name"),
                    ),
                  ),
                ),
              ],
            ),
            Button(
                text: "Save",
                onPressed: () {
                  if (nameController.text != "") {
                    ref
                        .read(ragComponentsProvider.notifier)
                        .addLanguageModel(nameController.text);
                    Navigator.pop(context);
                  }
                })
          ],
        ));
  }
}
