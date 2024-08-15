import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rag_tco/data_model/old/report_configuration.dart';
import 'package:rag_tco/data_model/old/report_storage.dart';
import 'package:rag_tco/misc/provider.dart';

class ReportConfigurationTable extends ConsumerWidget {
  const ReportConfigurationTable({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ReportStorage reportStorage = ref.watch(reportStorageProvider);
    return Table(
      border: TableBorder.all(color: Colors.black),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        const TableRow(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            children: [
              TableCell(
                  child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Name"),
              )),
              TableCell(
                  child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Configuration"),
              ))
            ]),
        for (int i = 0; i < reportStorage.reportConfigurations.length; i++)
          TableRow(children: [
            TableCell(
                child: Text(
                    reportStorage.reportConfigurations[i].configurationName)),
            TableCell(
                child: Text(configurationStringBuilder(
                    reportStorage.reportConfigurations[i])))
          ])
      ],
    );
  }

  String configurationStringBuilder(ReportConfiguration configuration) {
    return "Selected Service Entry: ${configuration.selectedService}";
  }
}
