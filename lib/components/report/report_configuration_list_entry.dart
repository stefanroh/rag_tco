import 'package:flutter/material.dart';
import 'package:rag_tco/components/report/report_configuration_edit.dart';

class ReportConfigurationListEntry extends StatelessWidget {
  const ReportConfigurationListEntry(
      {super.key, required this.displayText, required this.configurationIndex});

  final String displayText;
  final int configurationIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: ListTile(
            contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
            title: Text(displayText),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            onTap: () => configurationEditDialog(context, configurationIndex)));
    //tileColor: const Color.fromRGBO(220, 220, 220, 0.5)));
  }

  Future<void> configurationEditDialog(
      BuildContext context, int selectedConfigurationIndex) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return ReportConfigurationEdit(
            selectedReportIndex: selectedConfigurationIndex,
          );
        });
  }
}
