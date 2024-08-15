import 'package:flutter/material.dart';
import 'package:rag_tco/components/button.dart';
import 'package:rag_tco/components/report/report_configuration_add.dart';
import 'package:rag_tco/components/report/report_configuration_list.dart';
import 'package:rag_tco/components/report/service_cost_bar_chart.dart';
import 'package:rag_tco/components/service/old/timeframe_selector.dart';
import 'package:rag_tco/data_model/old/timeframe_type.dart';

class Report extends StatefulWidget {
  const Report({super.key});

  @override
  State<StatefulWidget> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  TimeframeType timeframe = TimeframeType.day;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Button(
                  text: "Add Report Configuration",
                  onPressed: () => costEntryAddDialog(context)),
            ),
            ReportConfigurationList(
              width: 300,
              height: MediaQuery.of(context).size.height - 50,
            )
          ],
        ),
        Container(
          width: 0.25,
          color: Colors.black,
        ),
        Expanded(
            child: Column(children: [
          const Text("Report", style: TextStyle(fontSize: 20)),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Select Reporting Timeframe"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TimeframeSelector(
                  onSelect: (val) => setState(() {
                        timeframe = val;
                      }),
                  width: 250,
                  initialTimeframe: timeframe),
            )
          ]),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: ServiceCostBarChart(
              timeframe: timeframe,
            ),
          ),
          // const ServiceCostCalculationTable(
          //   configIndex: 0,
          //   timeframe: TimeframeType.day,
          // )
        ]))
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
