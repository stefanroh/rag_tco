import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rag_tco/components/report/old/report_configuration_list_entry.dart';
import 'package:rag_tco/data_model/old/report_storage.dart';
import 'package:rag_tco/misc/provider.dart';

class ReportConfigurationList extends ConsumerWidget {
  const ReportConfigurationList(
      {super.key, required this.width, required this.height});

  final double width;
  final double height;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ReportStorage reportStorage = ref.watch(reportStorageProvider);

    return SizedBox(
      width: width,
      height: height,
      child: ListView(children: getListEntries(reportStorage)),
    );
  }

  List<Widget> getListEntries(ReportStorage storage) {
    List<Widget> returnList = [];
    for (int i = 0; i < storage.reportConfigurations.length; i++) {
      returnList.add(ReportConfigurationListEntry(
        displayText: storage.reportConfigurations[i].configurationName,
        configurationIndex: i,
      ));
    }
    return returnList;
  }
}
