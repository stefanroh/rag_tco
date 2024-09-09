import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rag_tco/data_model/old/rag_component_language_model.dart';
import 'package:rag_tco/data_model/old/rag_components.dart';
import 'package:rag_tco/misc/provider.dart';

class LanguageModelSelector extends ConsumerWidget {
  const LanguageModelSelector(
      {super.key,
      required this.onSelected,
      required this.width,
      required this.initialSelection});
  final Function(RagComponentLanguageModel?) onSelected;
  final double width;
  final RagComponentLanguageModel? initialSelection;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<RagComponents> asyncComponent = ref.watch(ragComponentsProvider);

    switch (asyncComponent) {
      case AsyncData(:final value):
        return DropdownMenu<RagComponentLanguageModel?>(
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

  List<DropdownMenuEntry<RagComponentLanguageModel?>> getEntries(
      RagComponents ragComponents) {
    List<DropdownMenuEntry<RagComponentLanguageModel?>> returnList =
        ragComponents.lanugageModels
            .map((element) => DropdownMenuEntry<RagComponentLanguageModel?>(
                value: element, label: element.name))
            .toList();
    returnList.add(const DropdownMenuEntry<RagComponentLanguageModel?>(
        value: null, label: "-- None --"));
    return returnList;
  }
}
