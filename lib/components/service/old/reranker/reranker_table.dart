import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rag_tco/components/button.dart';
import 'package:rag_tco/components/service/old/reranker/reranker_edit.dart';
import 'package:rag_tco/data_model/old/rag_component_reranker.dart';
import 'package:rag_tco/data_model/old/rag_components.dart';
import 'package:rag_tco/misc/provider.dart';

class RerankerTable extends ConsumerWidget {
  const RerankerTable({super.key});

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
            for (RagComponentReranker model in value.reranker)
              TableRow(children: [
                TableCell(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(model.name),
                )),
                TableCell(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(getConfigurationString(model)),
                )),
                TableCell(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Button(
                      text: "Edit",
                      onPressed: () => _rerankerEditDialog(context, model)),
                )),
                TableCell(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Button(
                      text: "Remove",
                      onPressed: () => (ref
                          .read(ragComponentsProvider.notifier)
                          .removeReranker(model))),
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
                      ref.read(ragComponentsProvider.notifier).addReranker(
                          RagComponentReranker(
                              name: nameController.text,
                              compressionRate: 1,
                              usecompressionModel: true,
                              rerankedDocuments: 0));
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

  Future<void> _rerankerEditDialog(
      BuildContext context, RagComponentReranker model) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return RerankerEdit(model);
        });
  }

  String getConfigurationString(RagComponentReranker reranker) {
    if (reranker.usecompressionModel) {
      return "Compression Model\nCompression Rate: ${reranker.compressionRate}";
    } else {
      return "Fix Documents Model\nReturned Documents: ${reranker.rerankedDocuments}";
    }
  }
}
