import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rag_tco/data_model/new/rag_component_storage.dart';
import 'package:rag_tco/data_model/new/rag_components.dart';
import 'package:rag_tco/misc/provider.dart';

class StorageSelector extends ConsumerWidget {
  const StorageSelector( 
      {super.key, required this.onSelected, required this.width, required this.initialSelection});
  final Function(RagComponentStorage?) onSelected;
  final double width;
  final RagComponentStorage? initialSelection;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<RagComponents> asyncComponent = ref.watch(ragComponentsProvider);

    switch (asyncComponent) {
      case AsyncData(:final value):
        return DropdownMenu<RagComponentStorage?>(
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

  List<DropdownMenuEntry<RagComponentStorage?>> getEntries(
      RagComponents ragComponents) {
    List<DropdownMenuEntry<RagComponentStorage?>> returnList =
        ragComponents.storages
            .map((element) => DropdownMenuEntry<RagComponentStorage?>(
                value: element, label: element.name))
            .toList();
    returnList.add(const DropdownMenuEntry<RagComponentStorage?>(
        value: null, label: "-- None --"));
    return returnList;
  }
}