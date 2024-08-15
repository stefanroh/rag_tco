import 'package:flutter/material.dart';
import 'package:multi_dropdown/models/value_item.dart';
import 'package:rag_tco/components/report/cost_entry_multiple_selector.dart';
import 'package:rag_tco/data_model/old/cost_entry.dart';
import 'package:rag_tco/data_model/old/cost_entry_types.dart';

class ReportConfigurationElement extends StatelessWidget {
  const ReportConfigurationElement(
      {super.key,
      required this.text,
      required this.costEntryList,
      required this.type,
      required this.onPress, this.selectedOptions = const []});

  final String text;
  final List<CostEntry> costEntryList;
  final CostEntryTypes type;
  final Function(CostEntryTypes, List<ValueItem<int>>) onPress;
  final List<int> selectedOptions;

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: costEntryList.isNotEmpty,
        child: Row(
          children: [
            SizedBox(
              width: 250,
              child: Text(text),
            ),
            CostEntryMultipleSelector(
              // initialSelection: -1,
              onSelect: (val) => onPress(type, val),
              costEntryList: costEntryList,
              selectedOptions: selectedOptions,
            ),
          ],
        ));
  }
}
