import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rag_tco/components/button.dart';
import 'package:rag_tco/data_model/old/rag_component_preprocessor.dart';
import 'package:rag_tco/misc/provider.dart';

class PreprocessorEdit extends ConsumerWidget {
  PreprocessorEdit(this.model, {super.key});
  final RagComponentPreprocessor model;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController costPerOperationController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    nameController.text = model.name;
    costPerOperationController.text = model.costPerOperation.toString();

    return AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Edit Preprocessor"),
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
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 3),
                  child: SizedBox(
                    width: 250,
                    child: Text("Cost per Operation"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: SizedBox(
                    width: 250,
                    child: TextField(
                      controller: costPerOperationController,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,10}'))
                      ],
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), hintText: "Cost per Update"),
                    ),
                  ),
                ),
              ],
            ),
            Button(
                text: "Save",
                onPressed: () {
                  if (nameController.text != "" &&
                      costPerOperationController.text != "") {
                    ref.read(ragComponentsProvider.notifier).updatePreprocessor(
                        model,
                        newName: nameController.text,
                        newCostPerOperation: double.parse(costPerOperationController.text));
                    Navigator.pop(context);
                  }
                })
          ],
        ));
  }
}
