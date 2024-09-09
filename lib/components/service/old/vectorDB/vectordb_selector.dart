import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rag_tco/data_model/old/rag_component_vectordb.dart';
import 'package:rag_tco/data_model/old/rag_components.dart';
import 'package:rag_tco/misc/provider.dart';

class VectordbSelector extends ConsumerWidget {
  const VectordbSelector(
      {super.key,
      required this.onSelected,
      required this.width,
      required this.initialSelection});
  final Function(RagComponentVectordb?) onSelected;
  final double width;
  final RagComponentVectordb? initialSelection;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<RagComponents> asyncComponent = ref.watch(ragComponentsProvider);

    switch (asyncComponent) {
      case AsyncData(:final value):
        return DropdownMenu<RagComponentVectordb?>(
          dropdownMenuEntries: getEntries(value),
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

  List<DropdownMenuEntry<RagComponentVectordb?>> getEntries(
      RagComponents ragComponents) {
    List<DropdownMenuEntry<RagComponentVectordb?>> returnList = ragComponents
        .vectorDBs
        .map((element) => DropdownMenuEntry<RagComponentVectordb?>(
            value: element, label: element.name))
        .toList();
    returnList.add(const DropdownMenuEntry<RagComponentVectordb?>(
        value: null, label: "-- None --"));
    return returnList;
  }
}
