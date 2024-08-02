
import 'package:flutter/material.dart';
import 'package:rag_tco/components/button.dart';
import 'package:rag_tco/components/report/report_configuration_add.dart';
import 'package:rag_tco/components/report/report_configuration_table.dart';
import 'package:rag_tco/components/report/total_cost_bar_chart.dart';
import 'package:rag_tco/components/service/timeframe_selector.dart';
import 'package:rag_tco/data_model/timeframe_type.dart';

class Report extends StatefulWidget {
  const Report({super.key});

  @override
  State<StatefulWidget> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  TimeframeType timeframe = TimeframeType.day;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ReportConfigurationTable(),
        Button(
            text: "Add Report Configuration",
            onPressed: () => costEntryAddDialog(context)),
        TimeframeSelector(
            onSelect: (val) => setState(() {
                  timeframe = val;
                }),
            width: 250,
            initialTimeframe: timeframe),
        TotalCostBarChart(
          timeframe: timeframe,
        ),
        // for (int i = 0; i < 7; i++)
        //   for (int j = i; j < 7; j++)
        //     Text(
        //         "From ${TimeframeType.values[i]} to ${TimeframeType.values[j]}: ${ReportUtils.getConversionFactor(TimeframeType.values[i], TimeframeType.values[j])}")
      ],
    );
  }

  Future<void> costEntryAddDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return const ReportConfigurationAdd();
        });
  }
}
