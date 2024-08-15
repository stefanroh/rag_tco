import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rag_tco/data_model/new/rag_component_reranker.dart';
import 'package:rag_tco/data_model/new/rag_components.dart';
import 'package:rag_tco/misc/provider.dart';

class RerankerSelector extends ConsumerWidget {
  const RerankerSelector( 
      {super.key, required this.onSelected, required this.width, required this.initialSelection});
  final Function(RagComponentReranker?) onSelected;
  final double width;
  final RagComponentReranker? initialSelection;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<RagComponents> asyncComponent = ref.watch(ragComponentsProvider);

    switch (asyncComponent) {
      case AsyncData(:final value):
        List<DropdownMenuEntry<RagComponentReranker>> entries = value.reranker
            .map((element) =>
                DropdownMenuEntry(value: element, label: element.name))
            .toList();
        return DropdownMenu<RagComponentReranker>(
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
