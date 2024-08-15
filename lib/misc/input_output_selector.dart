import 'package:flutter/material.dart';

class InputOutputSelector extends StatelessWidget {
  const InputOutputSelector(
      {super.key,
      required this.width,
      required this.initialSelection,
      required this.onSelect,
      required this.entries});
  final double width;
  final bool initialSelection;
  final Function(bool) onSelect;
  final List<DropdownMenuEntry<bool>> entries;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<bool>(
        width: width,
        initialSelection: initialSelection,
        onSelected: (value) => onSelect(value ?? true),
        dropdownMenuEntries: entries);
  }
}
