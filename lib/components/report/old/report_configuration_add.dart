import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:rag_tco/components/button.dart';
import 'package:rag_tco/components/report/old/report_configuration_element.dart';
import 'package:rag_tco/data_model/old/cost_entry_types.dart';
import 'package:rag_tco/data_model/old/data_storage.dart';
import 'package:rag_tco/data_model/old/report_configuration.dart';
import 'package:rag_tco/misc/provider.dart';

class ReportConfigurationAdd extends ConsumerStatefulWidget {
  const ReportConfigurationAdd({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ReportConfigurationAddState();
}

class _ReportConfigurationAddState
    extends ConsumerState<ReportConfigurationAdd> {
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
    DataStorage dataStorage = ref.watch(dataStorageProvider);
    TextEditingController configurationNameController = TextEditingController();

    return AlertDialog(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Add Reportconfiguration"),
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
            ),
            Button(
                text: "Add Report Configuration",
                onPressed: () {
                  if (configurationNameController.text != "") {
                    ref
                        .read(reportStorageProvider.notifier)
                        .addReportConfiguration(ReportConfiguration(
                            configurationName: configurationNameController.text,
                            selectedStrategic: selectedStrategic,
                            selectedEvaluation: selectedEvaluation,
                            selectedEmployee: selectedEmployee,
                            selectedImplementation: selectedImplementation,
                            selectedReversal: selectedReversal,
                            selectedService: selectedService,
                            selectedTraining: selectedTraining,
                            selectedMaintainance: selectedMaintainance,
                            selectedFailure: selectedFailure,
                            selectedSupport: selectedSupport));
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
