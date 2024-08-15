import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rag_tco/components/button.dart';
import 'package:rag_tco/components/service/new/retriever/retriever_edit.dart';
import 'package:rag_tco/data_model/new/rag_component_retriever.dart';
import 'package:rag_tco/data_model/new/rag_components.dart';
import 'package:rag_tco/misc/provider.dart';

class RetrieverTable extends ConsumerWidget {
  const RetrieverTable({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<RagComponents> asyncComponents =
        ref.watch(ragComponentsProvider);

    TextEditingController nameController = TextEditingController();
    switch (asyncComponents) {
      case AsyncData(:final value):
        return Table(
          border: TableBorder.all(color: Colors.black),
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            const TableRow(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                children: [
                  TableCell(
                      child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Name"),
                  )),
                  TableCell(
                      child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Configuration"),
                  )),
                  TableCell(
                      child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Edit"),
                  )),
                  TableCell(
                      child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Remove"),
                  ))
                ]),
            for (RagComponentRetriever model in value.retriever)
              TableRow(children: [
                TableCell(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(model.name),
                )),
                TableCell(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      "Top-K: ${model.retrievedDocuments.toString()}\nChunk Size: ${model.chunkSize}"),
                )),
                TableCell(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Button(
                      text: "Edit",
                      onPressed: () => _retrieverEditDialog(context, model)),
                )),
                TableCell(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Button(
                      text: "Remove",
                      onPressed: () => (ref
                          .read(ragComponentsProvider.notifier)
                          .removeRetriever(model))),
                ))
              ]),
            TableRow(children: [
              TableCell(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: "Name"),
                  controller: nameController,
                ),
              )),
              const TableCell(child: Text("")),
              const TableCell(child: Text("")),
              TableCell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Button(
                                    text: "Add",
                                    onPressed: () {
                    if (nameController.text != "") {
                      ref.read(ragComponentsProvider.notifier).addRetriever(
                          RagComponentRetriever(
                              name: nameController.text, retrievedDocuments: 0, chunkSize: 0));
                    }
                                    },
                                  ),
                  ))
            ])
          ],
        );
      case AsyncError(:final error):
        return Text("$error");
      default:
        return const Text("Loading");
    }
  }

  Future<void> _retrieverEditDialog(
      BuildContext context, RagComponentRetriever model) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return RetrieverEdit(model);
        });
  }
}
