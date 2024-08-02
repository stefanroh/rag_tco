
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:rag_tco/components/button.dart';
import 'package:rag_tco/components/report/cost_entry_multiple_selector.dart';
import 'package:rag_tco/data_model/cost_entry.dart';
import 'package:rag_tco/data_model/cost_entry_types.dart';
import 'package:rag_tco/data_model/data_storage.dart';
import 'package:rag_tco/data_model/report_configuration.dart';
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
            configurationElement("Servicegebühren", dataStorage.serviceEntries,
                CostEntryTypes.service),
            Button(
                text: "Add Report Configuraiton",
                onPressed: () => ref
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
                        selectedSupport: selectedSupport)))
          ],
        ));
  }

  Widget configurationElement(
      String text, List<CostEntry> costEntryList, CostEntryTypes type) {
    return Visibility(
        visible: costEntryList.isNotEmpty,
        child: Row(
          children: [
            SizedBox(
              width: 250,
              child: Text(text),
            ),
            CostEntryMultipleSelector(
              // initialSelection: -1,
              onSelect: (val) => _setChoice(type, val),
              costEntryList: costEntryList,
            ),
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
