import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rag_tco/data_model/new/rag_component_language_model.dart';
import 'package:rag_tco/data_model/new/rag_components.dart';
import 'package:rag_tco/misc/provider.dart';

class LanguageModelSelector extends ConsumerWidget {
  const LanguageModelSelector( 
      {super.key, required this.onSelected, required this.width, required this.initialSelection});
  final Function(RagComponentLanguageModel?) onSelected;
  final double width;
  final RagComponentLanguageModel? initialSelection;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<RagComponents> asyncComponent = ref.watch(ragComponentsProvider);

    switch (asyncComponent) {
      case AsyncData(:final value):
        List<DropdownMenuEntry<RagComponentLanguageModel>> entries = value
            .lanugageModels
            .map((element) =>
                DropdownMenuEntry(value: element, label: element.name))
            .toList();
        return DropdownMenu<RagComponentLanguageModel>(
          dropdownMenuEntries: entries,
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
}
