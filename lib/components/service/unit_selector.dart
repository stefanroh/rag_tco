import 'package:flutter/material.dart';
import 'package:rag_tco/data_model/provider_information.dart';
import 'package:rag_tco/data_model/unit_types.dart';

class UnitTypeSelector extends StatelessWidget {
  const UnitTypeSelector(
      {super.key, required this.onSelect, required this.width});

  final Function(UnitTypes unitType) onSelect;
  final double width;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
        width: width,
        initialSelection: UnitTypes.token,
        onSelected: (value) => onSelect(value ?? UnitTypes.unknown),
        dropdownMenuEntries: [
          for (UnitTypes unit in UnitTypes.values)
            DropdownMenuEntry(
                value: unit, label: ProviderInformation.getUnitTypeString(unit))
        ]);
  }
}
