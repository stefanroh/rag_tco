import 'package:flutter/material.dart';
import 'package:rag_tco/data_model/cost_entry.dart';

class CostEntrySelector extends StatelessWidget {
  const CostEntrySelector(
      {required this.costEntryList,
      required this.onSelect,
      required this.initialSelection,
      super.key});

  final List<CostEntry> costEntryList;
  final Function(int) onSelect;
  final int initialSelection;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      width: 250,
        initialSelection: initialSelection,
        onSelected: (val) => onSelect(val),
        dropdownMenuEntries: getMenuEntries());
  }

  List<DropdownMenuEntry> getMenuEntries() {
    List<DropdownMenuEntry<int>> returnList = [];
    returnList.add(const DropdownMenuEntry(value: -1, label: "Not Selected"));
    for (int i = 0; i < costEntryList.length; i++) {
      returnList
          .add(DropdownMenuEntry(value: i, label: costEntryList[i].entryName));
    }
    return returnList;
  }
}
