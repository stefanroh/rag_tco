import 'package:flutter/material.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:rag_tco/data_model/cost_entry.dart';

class CostEntryMultipleSelector extends StatelessWidget {
  const CostEntryMultipleSelector(
      {super.key, required this.onSelect, required this.costEntryList});

  final Function(List<ValueItem<int>>) onSelect;
  final List<CostEntry> costEntryList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 50,
        width: 250,
        child: MultiSelectDropDown<int>(
            onOptionSelected: onSelect, options: getMenuEntries()));
  }

  List<ValueItem<int>> getMenuEntries() {
    List<ValueItem<int>> returnList = [];
    // returnList.add(const ValueItem(value: -1, label: "Not Selected"));
    for (int i = 0; i < costEntryList.length; i++) {
      returnList.add(ValueItem(value: i, label: costEntryList[i].entryName));
    }
    return returnList;
  }
}
