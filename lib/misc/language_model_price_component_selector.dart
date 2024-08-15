import 'package:flutter/material.dart';
import 'package:rag_tco/misc/language_model_price_component_types.dart';

class LanguageModelPriceComponentSelector extends StatelessWidget {
  const LanguageModelPriceComponentSelector(
      {super.key,
      required this.width,
      required this.initialSelection,
      required this.onSelect,
      required this.entries});
  final double width;
  final LanguageModelPriceComponentTypes initialSelection;
  final Function(LanguageModelPriceComponentTypes?) onSelect;
  final List<DropdownMenuEntry<LanguageModelPriceComponentTypes>> entries;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<LanguageModelPriceComponentTypes>(
        width: width,
        initialSelection: initialSelection,
        onSelected: (value) => onSelect(value),
        dropdownMenuEntries: entries);
  }
}
