import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rag_tco/components/button.dart';
import 'package:rag_tco/data_model/new/rag_component_reranker.dart';
import 'package:rag_tco/misc/provider.dart';

class RerankerEdit extends ConsumerStatefulWidget {
  const RerankerEdit(this.model, {super.key});
  final RagComponentReranker model;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RerankerEditState();
}

class _RerankerEditState extends ConsumerState<RerankerEdit> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController compactionController = TextEditingController();
  final TextEditingController rerankedDocumentsController =
      TextEditingController();

  late bool isCompactionModel;

  @override
  void initState() {
    super.initState();
    isCompactionModel = widget.model.useCompactionModel;
    nameController.text = widget.model.name;
    compactionController.text = widget.model.compactionRate.toString();
    rerankedDocumentsController.text =
        widget.model.rerankedDocuments.toString();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Edit Reranker"),
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
                    child: Text("Model Type"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: DropdownMenu<bool>(
                    dropdownMenuEntries: const [
                      DropdownMenuEntry<bool>(
                          value: true, label: "Compaction Model"),
                      DropdownMenuEntry<bool>(
                          value: false, label: "Fix Documents Model")
                    ],
                    onSelected: (value) => setState(() {
                      isCompactionModel = value!;
                    }),
                    initialSelection: isCompactionModel,
                    width: 250,
                  ),
                ),
              ],
            ),
            Visibility(
              visible: isCompactionModel,
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 3),
                    child: SizedBox(
                      width: 250,
                      child: Text("Compaction Rate"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: SizedBox(
                      width: 250,
                      child: TextField(
                        controller: compactionController,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^(\d+)?\.?\d{0,2}'))
                        ],
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Compaction Rate"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: !isCompactionModel,
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 3),
                    child: SizedBox(
                      width: 250,
                      child: Text("Reranked Documents"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: SizedBox(
                      width: 250,
                      child: TextField(
                        controller: rerankedDocumentsController,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^(\d+)?\.?\d{0,2}'))
                        ],
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Compaction Rate"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Button(
                text: "Save",
                onPressed: () {
                  if (isCompactionModel &&
                      nameController.text != "" &&
                      compactionController.text != "") {
                    ref.read(ragComponentsProvider.notifier).updateReranker(
                        widget.model,
                        newName: nameController.text,
                        newCompactionRate:
                            double.parse(compactionController.text),
                        newRerankedDocuments: 0,
                        newUseCompactionModel: isCompactionModel);
                    Navigator.pop(context);
                  }
                  if (!isCompactionModel &&
                      nameController.text != "" &&
                      rerankedDocumentsController.text != "") {
                    ref.read(ragComponentsProvider.notifier).updateReranker(
                        widget.model,
                        newName: nameController.text,
                        newCompactionRate: 1,
                        newRerankedDocuments:
                            int.parse(rerankedDocumentsController.text),
                        newUseCompactionModel: isCompactionModel);
                    Navigator.pop(context);
                  }
                })
          ],
        ));
  }
}
