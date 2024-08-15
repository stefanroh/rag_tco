import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rag_tco/components/button.dart';
import 'package:rag_tco/components/service/old/service_entry_edit.dart';
import 'package:rag_tco/data_model/old/cost_entry_types.dart';
import 'package:rag_tco/data_model/old/data_storage.dart';
import 'package:rag_tco/data_model/old/provider_information.dart';
import 'package:rag_tco/data_model/old/cost_entry_service.dart';
import 'package:rag_tco/data_model/old/timeframe_type.dart';
import 'package:rag_tco/data_model/old/unit_types_legacy.dart';
import 'package:rag_tco/misc/provider.dart';

class ServiceEntryTable extends ConsumerWidget {
  const ServiceEntryTable({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<ProviderInformation> asyncProviderInformation =
        ref.watch(providerInformationProvider);
    DataStorage dataStorage = ref.watch(dataStorageProvider);

    return switch (asyncProviderInformation) {
      AsyncData(:final value) => SingleChildScrollView(
          child: Table(
            border: TableBorder.all(color: Colors.black),
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              const TableRow(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  children: [
                    TableCell(
                        child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Name"),
                    )),
                    TableCell(
                        child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Components"),
                    )),
                    TableCell(
                        child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Frequency"),
                    )),
                    TableCell(
                        child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Edit"),
                    )),
                    TableCell(
                        child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Remove"),
                    ))
                  ]),
              for (var i = 0; i < dataStorage.serviceEntries.length; i++)
                TableRow(children: [
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(dataStorage.serviceEntries[i].entryName),
                  )),
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(calculateComponentString(
                        dataStorage.serviceEntries[i],
                        value.serviceComponentNames[dataStorage
                            .serviceEntries[i]
                            .getProviderReference()],
                        value.serviceComponentPrices[dataStorage
                            .serviceEntries[i]
                            .getProviderReference()],
                        value.serviceComponentAmounts[dataStorage
                            .serviceEntries[i]
                            .getProviderReference()],
                        value.serviceComponentUnits[dataStorage
                            .serviceEntries[i]
                            .getProviderReference()])),
                  )),
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(calculateFrequencyString(
                        dataStorage.serviceEntries[i].referenceTimeframe,
                        dataStorage.serviceEntries[i].frequency)),
                  )),
                  TableCell(
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Button(
                              onPressed: () =>
                                  _serviceEntryEditDialog(context, i),
                              text: "Edit"))),
                  TableCell(
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Button(
                              onPressed: () {
                                ref
                                    .read(dataStorageProvider.notifier)
                                    .removeServiceEntry(i);
                                ref
                                    .read(reportStorageProvider.notifier)
                                    .removeServiceProvider(
                                        CostEntryTypes.service, i);
                              },
                              text: "Remove"))),
                ])
            ],
          ),
        ),
      AsyncError(:final error) => Text("$error"),
      _ => const Center(child: CircularProgressIndicator()),
    };
  }

  String calculateComponentString(
      CostEntryService serviceEntry,
      List<String> componentNames,
      List<double> componentPrices,
      List<int> componentAmount,
      List<UnitTypesLegacy> componentUnits) {
    List<double> amounts = serviceEntry.getAmounts();
    String returnString = "";

    for (int i = 0; i < amounts.length; i++) {
      returnString +=
          "${amounts[i]} * ${componentPrices[i]} / ${componentAmount[i]} ${ProviderInformation.getUnitTypesLegacytring(componentUnits[i])}";
      if (i != amounts.length - 1) returnString += "\n";
    }
    return returnString;
  }

  String calculateFrequencyString(TimeframeType timeframeType, int frequency) {
    return "${frequency}x / ${timeframeType.parseToString()}";
  }

  Future<void> _serviceEntryEditDialog(
      BuildContext context, int serviceEntryIndex) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return ServiceEntryEdit(serviceEntriesIndex: serviceEntryIndex);
        });
  }
}
