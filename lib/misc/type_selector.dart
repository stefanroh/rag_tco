import 'package:flutter/material.dart';
import 'package:rag_tco/data_model/architecture_component.dart';

class TypeSelector extends StatelessWidget {
  const TypeSelector(
      this.width, this.initialSelection, this.onSelect, this.components,
      {super.key});

  final double width;
  final String? initialSelection;
  final Function(String?) onSelect;
  final List<ArchitectureComponent> components;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: width,
      child: DropdownMenu<String?>(
          width: width,
          initialSelection: initialSelection,
          onSelected: (value) => onSelect(value),
          dropdownMenuEntries: getEntires()),
    );
  }

  List<DropdownMenuEntry<String?>> getEntires() {
    List<String> types =
        components.map((element) => element.type).toSet().toList();
    List<DropdownMenuEntry<String?>> entries = types
        .map((element) =>
            DropdownMenuEntry<String?>(label: element, value: element))
        .toList();
    entries.insert(0, const DropdownMenuEntry(value: null, label: "All"));
    return entries;
  }
}
