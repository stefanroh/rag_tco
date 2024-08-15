import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rag_tco/components/button.dart';
import 'package:rag_tco/data_model/new/rag_component_retriever.dart';
import 'package:rag_tco/misc/provider.dart';

class RetrieverAdd extends ConsumerStatefulWidget {
  const RetrieverAdd({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RetrieverAddState();
}

class _RetrieverAddState extends ConsumerState<RetrieverAdd> {
  TextEditingController nameController = TextEditingController();
  TextEditingController retrievedDocumentsController = TextEditingController();
  TextEditingController chunkSizeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Add Retriever"),
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
                    ref.read(ragComponentsProvider.notifier).addRetriever(
                        RagComponentRetriever(
                            name: nameController.text,
                            retrievedDocuments: int.parse(retrievedDocumentsController.text),
                            chunkSize: int.parse(chunkSizeController.text)));
                    Navigator.pop(context);
                  }
                })
          ],
        ));
  }
}
