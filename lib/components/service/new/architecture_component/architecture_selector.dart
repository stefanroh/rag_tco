import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rag_tco/data_model/new/architecture_component.dart';
import 'package:rag_tco/data_model/new/architecture_components_storage.dart';
import 'package:rag_tco/misc/provider.dart';

class ArchitectureSelector extends ConsumerWidget {
  const ArchitectureSelector(
      {super.key,
      required this.onSelected,
      required this.width,
      required this.initialSelection});
  final Function(ArchitectureComponent?) onSelected;
  final double width;
  final ArchitectureComponent? initialSelection;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<ArchitectureComponentsStorage> asyncStorage =
        ref.watch(architectureComponentProvider);

    switch (asyncStorage) {
      case AsyncData(:final value):
        return DropdownMenu<ArchitectureComponent?>(
          dropdownMenuEntries: getEntries(value.componentList),
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

  List<DropdownMenuEntry<ArchitectureComponent?>> getEntries(
      List<ArchitectureComponent> architectureComponents) {
    List<DropdownMenuEntry<ArchitectureComponent?>> returnList =
        architectureComponents
            .map((element) => DropdownMenuEntry<ArchitectureComponent?>(
                value: element, label: element.componentName))
            .toList();
    // returnList.add(const DropdownMenuEntry<ArchitectureComponent?>(
    //     value: null, label: "Chose Component"));
    return returnList;
  }
}
