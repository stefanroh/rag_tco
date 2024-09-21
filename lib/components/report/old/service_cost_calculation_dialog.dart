import 'package:flutter/material.dart';
import 'package:rag_tco/components/report/old/service_cost_calculation_table.dart';
import 'package:rag_tco/data_model/old/timeframe_type.dart';

class ServiceCostCalculationDialog extends StatelessWidget {
  const ServiceCostCalculationDialog(
      {super.key, required this.timeframe, required this.configIndex});

  final TimeframeType timeframe;
  final int configIndex;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Cost Calculation"),
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.clear),
            ),
          ],
        ),
        content: SingleChildScrollView(
            child: ServiceCostCalculationTable(
          timeframe: timeframe,
          configIndex: configIndex,
        )));
  }
}
