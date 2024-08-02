import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rag_tco/data_model/cost_entry_types.dart';
import 'package:rag_tco/data_model/report_configuration.dart';
import 'package:rag_tco/data_model/report_storage.dart';

class ReportStorageNotifier extends Notifier<ReportStorage> {
  void addReportConfiguration(ReportConfiguration newConfiguration) {
    List<ReportConfiguration> reportConfigurations =
        List<ReportConfiguration>.from(state.reportConfigurations);
    reportConfigurations.add(newConfiguration);
    state = state.copyWith(newReportConfigurations: reportConfigurations);
  }

  void removeServiceProvider(CostEntryTypes type, int serviceProviderIndex) {
    List<ReportConfiguration> reportConfigurations =
        List<ReportConfiguration>.from(state.reportConfigurations);
    for (int i = 0; i < reportConfigurations.length; i++) {
      reportConfigurations[i] = _removeServiceProviderFromEntry(
          type, serviceProviderIndex, reportConfigurations[i]);
    }
    state = state.copyWith(newReportConfigurations: reportConfigurations);
  }

  ReportConfiguration _removeServiceProviderFromEntry(CostEntryTypes type,
      int serviceProviderIndex, ReportConfiguration configuration) {
    switch (type) {
      case CostEntryTypes.strategic:
        if (configuration.selectedService.contains(serviceProviderIndex)) {
          configuration.selectedStrategic.removeWhere((item) => item == serviceProviderIndex);
        }
        return configuration;
      case CostEntryTypes.evaluation:
        if (configuration.selectedService.contains(serviceProviderIndex)) {
          configuration.selectedEvaluation.removeWhere((item) => item == serviceProviderIndex);
        }
        return configuration;
      case CostEntryTypes.employee:
        if (configuration.selectedService.contains(serviceProviderIndex)) {
          configuration.selectedEmployee.removeWhere((item) => item == serviceProviderIndex);
        }
        return configuration;
      case CostEntryTypes.implementation:
        if (configuration.selectedService.contains(serviceProviderIndex)) {
          configuration.selectedImplementation.removeWhere((item) => item == serviceProviderIndex);
        }
        return configuration;
      case CostEntryTypes.revearsal:
        if (configuration.selectedService.contains(serviceProviderIndex)) {
          configuration.selectedReversal.removeWhere((item) => item == serviceProviderIndex);
        }
        return configuration;
      case CostEntryTypes.service:
        if (configuration.selectedService.contains(serviceProviderIndex)) {
          configuration.selectedService.removeWhere((item) => item == serviceProviderIndex);
        }
        return configuration;
      case CostEntryTypes.training:
        if (configuration.selectedService.contains(serviceProviderIndex)) {
          configuration.selectedTraining.removeWhere((item) => item == serviceProviderIndex);
        }
        return configuration;
      case CostEntryTypes.maintainance:
        if (configuration.selectedService.contains(serviceProviderIndex)) {
          configuration.selectedMaintainance.removeWhere((item) => item == serviceProviderIndex);
        }
        return configuration;
      case CostEntryTypes.failure:
        if (configuration.selectedService.contains(serviceProviderIndex)) {
          configuration.selectedFailure.removeWhere((item) => item == serviceProviderIndex);
        }
        return configuration;
      case CostEntryTypes.support:
        if (configuration.selectedService.contains(serviceProviderIndex)) {
          configuration.selectedSupport.removeWhere((item) => item == serviceProviderIndex);
        }
        return configuration;
    }
  }

  @override
  ReportStorage build() {
    return const ReportStorage();
  }
}
