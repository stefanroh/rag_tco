import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rag_tco/components/button.dart';
import 'package:rag_tco/data_model/new/rag_component_retriever.dart';
import 'package:rag_tco/misc/provider.dart';

class RetrieverEdit extends ConsumerWidget {
  RetrieverEdit(this.model, {super.key});
  final RagComponentRetriever model;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController retrievedDocumentsController = TextEditingController();
  final TextEditingController chunkSizeController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    nameController.text = model.name;
    retrievedDocumentsController.text = model.retrievedDocuments.toString();
    chunkSizeController.text = model.chunkSize.toString();

    return AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Edit Retriever"),
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
                    child: Text("Top-K"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: SizedBox(
                    width: 250,
                    child: TextField(
                      controller: retrievedDocumentsController,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: false),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?'))
                      ],
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), hintText: "Top-K"),
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
                    child: Text("Chunk Size"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: SizedBox(
                    width: 250,
                    child: TextField(
                      controller: chunkSizeController,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: false),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?'))
                      ],
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), hintText: "Chunk Size"),
                    ),
                  ),
                ),
              ],
            ),
            Button(
                text: "Save",
                onPressed: () {
                  if (nameController.text != "" &&
                      chunkSizeController.text != "" &&
                      retrievedDocumentsController.text != "") {
                    ref.read(ragComponentsProvider.notifier).updateRetriever(
                        model,
                        newName: nameController.text,
                        newRetrievedDocuments: int.parse(retrievedDocumentsController.text),
                        newChunkSize: int.parse(chunkSizeController.text));
                    Navigator.pop(context);
                  }
                })
          ],
        ));
  }
}
