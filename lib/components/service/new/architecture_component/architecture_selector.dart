import 'package:flutter/material.dart';
import 'package:rag_tco/data_model/new/architecture_component.dart';

class ArchitectureSelector extends StatelessWidget {
  const ArchitectureSelector(
      {super.key,
      required this.onSelected,
      required this.width,
      required this.initialSelection,
      required this.components,
      required this.filterProvider,
      required this.filterType});
  final Function(ArchitectureComponent?) onSelected;
  final double width;
  final ArchitectureComponent? initialSelection;
  final String? filterProvider;
  final String? filterType;
  final List<ArchitectureComponent> components;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: width,
      child: DropdownMenu<ArchitectureComponent?>(
        dropdownMenuEntries: getEntries(components),
        initialSelection: initialSelection,
        width: width,
        onSelected: (val) => onSelected(val),
      ),
    );
  }

  List<DropdownMenuEntry<ArchitectureComponent?>> getEntries(
      List<ArchitectureComponent> architectureComponents) {
    List<DropdownMenuEntry<ArchitectureComponent?>> returnList =
        architectureComponents
            .map((element) => DropdownMenuEntry<ArchitectureComponent?>(
                value: element, label: element.componentName))
            .toList();
    if (filterProvider != null) {
      returnList
          .removeWhere((element) => element.value!.provider != filterProvider);
    }
    if (filterType != null) {
      returnList.removeWhere((element) => element.value!.type != filterType);
    }
    returnList.insert(
        0,
        const DropdownMenuEntry<ArchitectureComponent?>(
            value: null, label: "Chose Component"));
    return returnList;
  }
}
