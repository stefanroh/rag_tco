import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rag_tco/components/button.dart';
import 'package:rag_tco/data_model/old/rag_component_storage.dart';
import 'package:rag_tco/misc/provider.dart';

class StorageEdit extends ConsumerWidget {
  StorageEdit(this.model, {super.key});
  final RagComponentStorage model;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController costPerGBController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    nameController.text = model.name;
    costPerGBController.text = model.costPerGB.toString();

    return AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Edit Storage"),
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
                    child: Text("Cost per GB"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: SizedBox(
                    width: 250,
                    child: TextField(
                      controller: costPerGBController,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,10}'))
                      ],
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), hintText: "Cost per GB"),
                    ),
                  ),
                ),
              ],
            ),
            Button(
                text: "Save",
                onPressed: () {
                  if (nameController.text != "" &&
                      costPerGBController.text != "") {
                    ref.read(ragComponentsProvider.notifier).updateStorage(
                        model,
                        newName: nameController.text,
                        newCostPerGB: double.parse(costPerGBController.text));
                    Navigator.pop(context);
                  }
                })
          ],
        ));
  }
}
