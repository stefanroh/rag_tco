import 'package:flutter/material.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:rag_tco/data_model/old/cost_entry.dart';

class CostEntryMultipleSelector extends StatelessWidget {
  const CostEntryMultipleSelector(
      {super.key,
      required this.onSelect,
      required this.costEntryList,
      this.selectedOptions = const []});

  final Function(List<ValueItem<int>>) onSelect;
  final List<CostEntry> costEntryList;
  final List<int> selectedOptions;

  @override
  Widget build(BuildContext context) {
    List<ValueItem<int>> allItems = getMenuEntries();
    List<ValueItem<int>> selectedItems =
        getSelectedentries(allItems, selectedOptions);

    return SizedBox(
        height: 50,
        width: 250,
        child: MultiSelectDropDown<int>(
            onOptionSelected: onSelect, options: allItems, selectedOptions: selectedItems,));
  }

  List<ValueItem<int>> getMenuEntries() {
    List<ValueItem<int>> returnList = [];
    // returnList.add(const ValueItem(value: -1, label: "Not Selected"));
    for (int i = 0; i < costEntryList.length; i++) {
      returnList.add(ValueItem(value: i, label: costEntryList[i].entryName));
    }
    return returnList;
  }

  List<ValueItem<int>> getSelectedentries(
      List<ValueItem<int>> allItems, List<int> selectedItems) {
    List<ValueItem<int>> returnList = [];
    for (ValueItem<int> entry in allItems) {
      if (selectedItems.contains(entry.value)) {
        returnList.add(entry);
      }
    }
    return returnList;
  }
}
