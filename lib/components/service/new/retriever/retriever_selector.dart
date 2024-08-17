import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rag_tco/data_model/new/rag_component_retriever.dart';
import 'package:rag_tco/data_model/new/rag_components.dart';
import 'package:rag_tco/misc/provider.dart';

class RetrieverSelector extends ConsumerWidget {
  const RetrieverSelector(
      {super.key,
      required this.onSelected,
      required this.width,
      required this.initialSelection});
  final Function(RagComponentRetriever?) onSelected;
  final double width;
  final RagComponentRetriever? initialSelection;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<RagComponents> asyncComponent = ref.watch(ragComponentsProvider);

    switch (asyncComponent) {
      case AsyncData(:final value):
        return DropdownMenu<RagComponentRetriever?>(
          dropdownMenuEntries: getEntires(value),
          initialSelection: initialSelection,
          width: width,
          onSelected: (val) => onSelected(val),
        );
      case AsyncError(:final error):
        return Text("$error");
      default:
        return const Text("Loading");
    }
  }

  List<DropdownMenuEntry<RagComponentRetriever?>> getEntires(
      RagComponents ragComponents) {
    List<DropdownMenuEntry<RagComponentRetriever?>> returnList = ragComponents
        .retriever
        .map((element) => DropdownMenuEntry<RagComponentRetriever?>(
            value: element, label: element.name))
        .toList();
    returnList.add(const DropdownMenuEntry<RagComponentRetriever?>(
        value: null, label: "-- None --"));
    return returnList;
  }
}
