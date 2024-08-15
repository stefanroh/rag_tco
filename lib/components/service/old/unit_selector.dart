import 'package:flutter/material.dart';
import 'package:rag_tco/data_model/old/provider_information.dart';
import 'package:rag_tco/data_model/old/unit_types_legacy.dart';

class UnitTypesLegacyelector extends StatelessWidget {
  const UnitTypesLegacyelector(
      {super.key, required this.onSelect, required this.width});

  final Function(UnitTypesLegacy unitType) onSelect;
  final double width;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
        width: width,
        initialSelection: UnitTypesLegacy.token,
        onSelected: (value) => onSelect(value ?? UnitTypesLegacy.unknown),
        dropdownMenuEntries: [
          for (UnitTypesLegacy unit in UnitTypesLegacy.values)
            DropdownMenuEntry(
                value: unit, label: ProviderInformation.getUnitTypesLegacytring(unit))
        ]);
  }
}
