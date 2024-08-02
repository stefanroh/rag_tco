import 'package:flutter/material.dart';
import 'package:rag_tco/data_model/timeframe_type.dart';

class TimeframeSelector extends StatelessWidget {
  const TimeframeSelector(
      {super.key,
      required this.onSelect,
      required this.width,
      required this.initialTimeframe});

  final Function(TimeframeType timeframeType) onSelect;
  final double width;
  final TimeframeType initialTimeframe;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
        width: width,
        initialSelection: initialTimeframe,
        onSelected: (value) => onSelect(value ?? TimeframeType.day),
        dropdownMenuEntries: [
          for (TimeframeType unit in TimeframeType.values)
            DropdownMenuEntry(value: unit, label: unit.parseToString())
        ]);
  }
}
