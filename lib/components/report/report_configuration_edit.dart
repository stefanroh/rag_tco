import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multi_dropdown/models/value_item.dart';
import 'package:rag_tco/components/button.dart';
import 'package:rag_tco/components/report/report_configuration_element.dart';
import 'package:rag_tco/data_model/old/cost_entry_types.dart';
import 'package:rag_tco/data_model/old/data_storage.dart';
import 'package:rag_tco/data_model/old/report_configuration.dart';
import 'package:rag_tco/data_model/old/report_storage.dart';
import 'package:rag_tco/misc/provider.dart';

class ReportConfigurationEdit extends ConsumerStatefulWidget {
  const ReportConfigurationEdit({super.key, required this.selectedReportIndex});

  final int selectedReportIndex;

  @override
  ConsumerState<ReportConfigurationEdit> createState() =>
      _ReportConfigurationEditState();
}

class _ReportConfigurationEditState
    extends ConsumerState<ReportConfigurationEdit> {
  List<int> selectedStrategic = [];
  List<int> selectedEvaluation = [];
  List<int> selectedEmployee = [];
  List<int> selectedImplementation = [];
  List<int> selectedReversal = [];
  List<int> selectedService = [];
  List<int> selectedTraining = [];
  List<int> selectedMaintainance = [];
  List<int> selectedFailure = [];
  List<int> selectedSupport = [];

  @override
  Widget build(BuildContext context) {
    ReportStorage reportStorage = ref.watch(reportStorageProvider);
    DataStorage dataStorage = ref.watch(dataStorageProvider);

    selectedStrategic = reportStorage
        .reportConfigurations[widget.selectedReportIndex].selectedStrategic;
    selectedEvaluation = reportStorage
        .reportConfigurations[widget.selectedReportIndex].selectedEvaluation;
    selectedEmployee = reportStorage
        .reportConfigurations[widget.selectedReportIndex].selectedEmployee;
    selectedImplementation = reportStorage
        .reportConfigurations[widget.selectedReportIndex]
        .selectedImplementation;
    selectedReversal = reportStorage
        .reportConfigurations[widget.selectedReportIndex].selectedReversal;
    selectedService = reportStorage
        .reportConfigurations[widget.selectedReportIndex].selectedService;
    selectedTraining = reportStorage
        .reportConfigurations[widget.selectedReportIndex].selectedTraining;
    selectedMaintainance = reportStorage
        .reportConfigurations[widget.selectedReportIndex].selectedMaintainance;
    selectedFailure = reportStorage
        .reportConfigurations[widget.selectedReportIndex].selectedFailure;
    selectedSupport = reportStorage
        .reportConfigurations[widget.selectedReportIndex].selectedFailure;

    TextEditingController configurationNameController = TextEditingController(
        text: reportStorage.reportConfigurations[widget.selectedReportIndex]
            .configurationName);

    return AlertDialog(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Edit Reportconfiguration"),
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.clear),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                children: [
                  const SizedBox(width: 250, child: Text("Configuration Name")),
                  SizedBox(
                    width: 250,
                    child: TextField(
                      controller: configurationNameController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), hintText: "Name"),
                    ),
                  )
                ],
              ),
            ),
            ReportConfigurationElement(
              text: "Servicegebühren",
              costEntryList: dataStorage.serviceEntries,
              type: CostEntryTypes.service,
              onPress: (type, val) => _setChoice(type, val),
              selectedOptions: selectedService,
            ),
            Button(
                text: "Update Report Configuration",
                onPressed: () {
                  if (configurationNameController.text != "") {
                    ref
                        .read(reportStorageProvider.notifier)
                        .updateReportConfiguration(
                            ReportConfiguration(
                                configurationName:
                                    configurationNameController.text,
                                selectedStrategic: selectedStrategic,
                                selectedEvaluation: selectedEvaluation,
                                selectedEmployee: selectedEmployee,
                                selectedImplementation: selectedImplementation,
                                selectedReversal: selectedReversal,
                                selectedService: selectedService,
                                selectedTraining: selectedTraining,
                                selectedMaintainance: selectedMaintainance,
                                selectedFailure: selectedFailure,
                                selectedSupport: selectedSupport),
                            widget.selectedReportIndex);
                    Navigator.pop(context);
                  }
                })
          ],
        ));
  }

  void _setChoice(CostEntryTypes type, List<ValueItem<int>> selections) {
    List<int> selectionIntList = selections.map((item) => item.value!).toList();
    switch (type) {
      case CostEntryTypes.strategic:
        selectedStrategic = selectionIntList;
      case CostEntryTypes.evaluation:
        selectedEvaluation = selectionIntList;
      case CostEntryTypes.employee:
        selectedEmployee = selectionIntList;
      case CostEntryTypes.implementation:
        selectedImplementation = selectionIntList;
      case CostEntryTypes.revearsal:
        selectedReversal = selectionIntList;
      case CostEntryTypes.service:
        selectedService = selectionIntList;
      case CostEntryTypes.training:
        selectedTraining = selectionIntList;
      case CostEntryTypes.maintainance:
        selectedMaintainance = selectionIntList;
      case CostEntryTypes.failure:
        selectedFailure = selectionIntList;
      case CostEntryTypes.support:
        selectedSupport = selectionIntList;
    }
  }
}
