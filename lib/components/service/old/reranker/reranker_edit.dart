import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rag_tco/components/button.dart';
import 'package:rag_tco/data_model/old/rag_component_reranker.dart';
import 'package:rag_tco/misc/provider.dart';

class RerankerEdit extends ConsumerStatefulWidget {
  const RerankerEdit(this.model, {super.key});
  final RagComponentReranker model;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RerankerEditState();
}

class _RerankerEditState extends ConsumerState<RerankerEdit> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController compressionController = TextEditingController();
  final TextEditingController rerankedDocumentsController =
      TextEditingController();

  late bool iscompressionModel;

  @override
  void initState() {
    super.initState();
    iscompressionModel = widget.model.usecompressionModel;
    nameController.text = widget.model.name;
    compressionController.text = widget.model.compressionRate.toString();
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
                          value: true, label: "compression Model"),
                      DropdownMenuEntry<bool>(
                          value: false, label: "Fix Documents Model")
                    ],
                    onSelected: (value) => setState(() {
                      iscompressionModel = value!;
                    }),
                    initialSelection: iscompressionModel,
                    width: 250,
                  ),
                ),
              ],
            ),
            Visibility(
              visible: iscompressionModel,
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 3),
                    child: SizedBox(
                      width: 250,
                      child: Text("compression Rate"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: SizedBox(
                      width: 250,
                      child: TextField(
                        controller: compressionController,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^(\d+)?\.?\d{0,2}'))
                        ],
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "compression Rate"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: !iscompressionModel,
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
                            hintText: "compression Rate"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Button(
                text: "Save",
                onPressed: () {
                  if (iscompressionModel &&
                      nameController.text != "" &&
                      compressionController.text != "") {
                    ref.read(ragComponentsProvider.notifier).updateReranker(
                        widget.model,
                        newName: nameController.text,
                        newcompressionRate:
                            double.parse(compressionController.text),
                        newRerankedDocuments: 0,
                        newUsecompressionModel: iscompressionModel);
                    Navigator.pop(context);
                  }
                  if (!iscompressionModel &&
                      nameController.text != "" &&
                      rerankedDocumentsController.text != "") {
                    ref.read(ragComponentsProvider.notifier).updateReranker(
                        widget.model,
                        newName: nameController.text,
                        newcompressionRate: 1,
                        newRerankedDocuments:
                            int.parse(rerankedDocumentsController.text),
                        newUsecompressionModel: iscompressionModel);
                    Navigator.pop(context);
                  }
                })
          ],
        ));
  }
}
