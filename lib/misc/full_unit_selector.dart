import 'package:flutter/material.dart';

class FullUnitSelector extends StatelessWidget {
  const FullUnitSelector(this.width, this.initialSelection, this.onSelect, {super.key});

  final double width;
  final bool initialSelection;
  final Function(bool) onSelect;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<bool>(
        width: width,
        initialSelection: initialSelection,
        onSelected: (value) => onSelect(value ?? true),
        dropdownMenuEntries: const [
          DropdownMenuEntry(value: true, label: "Only full quantities"),
          DropdownMenuEntry(value: false, label: "Proportionate quantities")
        ]);
  }
}
