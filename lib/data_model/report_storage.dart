import 'package:rag_tco/data_model/report_configuration.dart';

class ReportStorage {
  const ReportStorage({this.reportConfigurations = const []});

  final List<ReportConfiguration> reportConfigurations;

  ReportStorage copyWith({List<ReportConfiguration>? newReportConfigurations}) {
    return ReportStorage(
        reportConfigurations: newReportConfigurations ?? reportConfigurations);
  }
}
