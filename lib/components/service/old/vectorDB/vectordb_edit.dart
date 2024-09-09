import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rag_tco/components/button.dart';
import 'package:rag_tco/data_model/old/rag_component_vectordb.dart';
import 'package:rag_tco/misc/provider.dart';

class VectordbEdit extends ConsumerWidget {
  VectordbEdit(this.model, {super.key});
  final RagComponentVectordb model;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController costPerUpdateController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    nameController.text = model.name;
    costPerUpdateController.text = model.costPerUpdate.toString();

    return AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Edit Vector DB"),
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
                    child: Text("Cost per Update"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: SizedBox(
                    width: 250,
                    child: TextField(
                      controller: costPerUpdateController,
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
                      costPerUpdateController.text != "") {
                    ref.read(ragComponentsProvider.notifier).updateVectorDB(
                        model,
                        newName: nameController.text,
                        newCostPerUpdate: double.parse(costPerUpdateController.text));
                    Navigator.pop(context);
                  }
                })
          ],
        ));
  }
}
