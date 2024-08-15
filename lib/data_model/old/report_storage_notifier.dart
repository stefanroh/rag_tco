import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rag_tco/data_model/old/cost_entry_types.dart';
import 'package:rag_tco/data_model/old/report_configuration.dart';
import 'package:rag_tco/data_model/old/report_storage.dart';

class ReportStorageNotifier extends Notifier<ReportStorage> {
  void addReportConfiguration(ReportConfiguration newConfiguration) {
    List<ReportConfiguration> reportConfigurations =
        List<ReportConfiguration>.from(state.reportConfigurations);
    reportConfigurations.add(newConfiguration);
    state = state.copyWith(newReportConfigurations: reportConfigurations);
  }

  void updateReportConfiguration(
      ReportConfiguration newConfiguration, int configurationindex) {
    List<ReportConfiguration> reportConfigurations =
        List<ReportConfiguration>.from(state.reportConfigurations);
    reportConfigurations[configurationindex] = newConfiguration;
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
        configuration.selectedStrategic = removeAndAdaptIndex(
            configuration.selectedStrategic, serviceProviderIndex);
        return configuration;
      case CostEntryTypes.evaluation:
        configuration.selectedEvaluation = removeAndAdaptIndex(
            configuration.selectedEvaluation, serviceProviderIndex);
        return configuration;
      case CostEntryTypes.employee:
        configuration.selectedEmployee = removeAndAdaptIndex(
            configuration.selectedEmployee, serviceProviderIndex);
        return configuration;
      case CostEntryTypes.implementation:
        configuration.selectedImplementation = removeAndAdaptIndex(
            configuration.selectedImplementation, serviceProviderIndex);
        return configuration;
      case CostEntryTypes.revearsal:
        configuration.selectedReversal = removeAndAdaptIndex(
            configuration.selectedReversal, serviceProviderIndex);
        return configuration;
      case CostEntryTypes.service:
        configuration.selectedService = removeAndAdaptIndex(
            configuration.selectedService, serviceProviderIndex);
        return configuration;
      case CostEntryTypes.training:
        configuration.selectedTraining = removeAndAdaptIndex(
            configuration.selectedTraining, serviceProviderIndex);
        return configuration;
      case CostEntryTypes.maintainance:
        configuration.selectedMaintainance = removeAndAdaptIndex(
            configuration.selectedMaintainance, serviceProviderIndex);
        return configuration;
      case CostEntryTypes.failure:
        configuration.selectedFailure = removeAndAdaptIndex(
            configuration.selectedFailure, serviceProviderIndex);
        return configuration;
      case CostEntryTypes.support:
        configuration.selectedSupport = removeAndAdaptIndex(
            configuration.selectedSupport, serviceProviderIndex);
        return configuration;
    }
  }

  List<int> removeAndAdaptIndex(List<int> list, int indexToRemove) {
    list.removeWhere((item) => item == indexToRemove);
    list = list
        .map((element) => element > indexToRemove ? element - 1 : element)
        .toList();
    return list;
  }

  @override
  ReportStorage build() {
    return const ReportStorage();
  }
}
