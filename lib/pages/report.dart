import 'package:flutter/material.dart';
import 'package:rag_tco/components/button.dart';
import 'package:rag_tco/components/report/report_configuration_add.dart';
import 'package:rag_tco/components/report/report_configuration_table.dart';

class Report extends StatelessWidget {
  const Report({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ReportConfigurationTable(),
        Button(
            text: "Add Report Configuration",
            onPressed: () => costEntryAddDialog(context)),
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
