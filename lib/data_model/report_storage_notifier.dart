import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rag_tco/data_model/report_configuration.dart';
import 'package:rag_tco/data_model/report_storage.dart';

class ReportStorageNotifier extends Notifier<ReportStorage> {
  
  void addReportConfiguration(ReportConfiguration newConfiguration) {
    List<ReportConfiguration> reportConfigurations =
        List<ReportConfiguration>.from(state.reportConfigurations);
    reportConfigurations.add(newConfiguration);
    state = state.copyWith(newReportConfigurations: reportConfigurations);
  }

  @override
  ReportStorage build() {
    return const ReportStorage();
  }
}
