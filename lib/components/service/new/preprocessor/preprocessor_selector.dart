import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rag_tco/data_model/new/rag_component_preprocessor.dart';
import 'package:rag_tco/data_model/new/rag_components.dart';
import 'package:rag_tco/misc/provider.dart';

class PreprocessorSelector extends ConsumerWidget {
  const PreprocessorSelector(
      {super.key,
      required this.onSelected,
      required this.width,
      required this.initialSelection});
  final Function(RagComponentPreprocessor?) onSelected;
  final double width;
  final RagComponentPreprocessor? initialSelection;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<RagComponents> asyncComponent = ref.watch(ragComponentsProvider);

    switch (asyncComponent) {
      case AsyncData(:final value):
        return DropdownMenu<RagComponentPreprocessor?>(
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

  List<DropdownMenuEntry<RagComponentPreprocessor?>> getEntries(
      RagComponents ragComponents) {
    List<DropdownMenuEntry<RagComponentPreprocessor?>> returnList =
        ragComponents.preprocessors
            .map((element) => DropdownMenuEntry<RagComponentPreprocessor?>(
                value: element, label: element.name))
            .toList();
    returnList.add(DropdownMenuEntry<RagComponentPreprocessor?>(
        value: null, label: "-- None --"));
    return returnList;
  }
}
