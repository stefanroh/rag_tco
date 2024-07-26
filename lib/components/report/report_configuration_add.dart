import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rag_tco/components/button.dart';
import 'package:rag_tco/components/report/cost_entry_selector.dart';
import 'package:rag_tco/data_model/cost_entry.dart';
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
  int selectedStrategic = -1;
  int selectedEvaluation = -1;
  int selectedEmployee = -1;
  int selectedImplementation = -1;
  int selectedReversal = -1;
  int selectedService = -1;
  int selectedTraining = -1;
  int selectedMaintainance = -1;
  int selectedFailure = -1;
  int selectedSupport = -1;

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
            configurationElement(
                "Servicegebühren", dataStorage.serviceEntries, selectedService),
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
      String text, List<CostEntry> costEntryList, int selectedIndex) {
    return Visibility(
        visible: costEntryList.isNotEmpty,
        child: Row(
          children: [
            SizedBox(
              width: 250,
              child: Text(text),
            ),
            CostEntrySelector(
              initialSelection: -1,
              onSelect: (val) => selectedIndex = val,
              costEntryList: costEntryList,
            ),
          ],
        ));
  }
}
