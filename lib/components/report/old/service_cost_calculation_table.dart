import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rag_tco/components/report/old/report_utils.dart';
import 'package:rag_tco/data_model/old/data_storage.dart';
import 'package:rag_tco/data_model/old/provider_information.dart';
import 'package:rag_tco/data_model/old/report_configuration.dart';
import 'package:rag_tco/data_model/old/report_storage.dart';
import 'package:rag_tco/data_model/old/timeframe_type.dart';
import 'package:rag_tco/misc/provider.dart';

class ServiceCostCalculationTable extends ConsumerWidget {
  const ServiceCostCalculationTable(
      {super.key, required this.configIndex, required this.timeframe});

  final int configIndex;
  final TimeframeType timeframe;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DataStorage dataStorage = ref.watch(dataStorageProvider);
    ReportStorage reportStorage = ref.watch(reportStorageProvider);
    AsyncValue<ProviderInformation> providerInformation =
        ref.watch(providerInformationProvider);

    switch (providerInformation) {
      case AsyncData(:final value):
        if (reportStorage.reportConfigurations.isEmpty) {
          return const Text("Empty");
        }
        return SizedBox(
          width: 750,
          child: Table(
            border: TableBorder.all(color: Colors.black),
            children: getTableRowByConfig(
                reportStorage.reportConfigurations[configIndex],
                value,
                dataStorage),
          ),
        );
      default:
        return const Text("Not Loaded");
    }
  }

  List<TableRow> getTableRowByConfig(ReportConfiguration config,
      ProviderInformation providerInformation, DataStorage dataStorage) {
    List<TableRow> returnList = [];
    returnList.add(const TableRow(children: [
      TableCell(child: Text("Service Cost Entry")),
      TableCell(child: Text("Component Name")),
      TableCell(child: Text("Cost Factor")),
      TableCell(child: Text("Amount")),
      TableCell(child: Text("Base Cost")),
      TableCell(child: Text("Frequency")),
      TableCell(child: Text("Timeframe Cost")),
      TableCell(child: Text("Report Scalled Cost")),
    ]));
    for (int i = 0; i < config.selectedService.length; i++) {
      returnList.addAll(getTableRowsByEntry(
          config.selectedService[i], providerInformation, dataStorage));
    }
    return returnList;
  }

  List<TableRow> getTableRowsByEntry(int serviceEntryIndex,
      ProviderInformation providerInformation, DataStorage dataStorage) {
    List<TableRow> returnList = [];
    double totalTimeframeCost = 0;
    double totalReportCost = 0;

    for (int i = 0;
        i <
            providerInformation
                .serviceComponentNames[dataStorage
                    .serviceEntries[serviceEntryIndex]
                    .getProviderReference()]
                .length;
        i++) {
      double costFactor = providerInformation.serviceComponentPrices[dataStorage
              .serviceEntries[serviceEntryIndex]
              .getProviderReference()][i] /
          providerInformation.serviceComponentAmounts[dataStorage
              .serviceEntries[serviceEntryIndex]
              .getProviderReference()][i];
      double amount =
          dataStorage.serviceEntries[serviceEntryIndex].getAmounts()[i];
      double frequency =
          dataStorage.serviceEntries[serviceEntryIndex].frequency as double;
      double timeframeMultiplier = ReportUtils.getConversionFactor(
          dataStorage.serviceEntries[serviceEntryIndex].referenceTimeframe,
          timeframe);

      returnList.add(TableRow(children: [
        TableCell(
            child: i == 0
                ? Text(dataStorage.serviceEntries[serviceEntryIndex].entryName)
                : const Text("")),
        TableCell(
            child: Text(providerInformation.serviceComponentNames[dataStorage
                .serviceEntries[serviceEntryIndex]
                .getProviderReference()][i])),
        TableCell(
            child: Text(
                "${providerInformation.serviceComponentPrices[dataStorage.serviceEntries[serviceEntryIndex].getProviderReference()][i]} / ${providerInformation.serviceComponentAmounts[dataStorage.serviceEntries[serviceEntryIndex].getProviderReference()][i]} ${ProviderInformation.getUnitTypesLegacytring(providerInformation.serviceComponentUnits[dataStorage.serviceEntries[serviceEntryIndex].getProviderReference()][i])}")),
        TableCell(
            child: Text(dataStorage.serviceEntries[serviceEntryIndex]
                .getAmounts()[i]
                .toString())),
        TableCell(child: Text((costFactor * amount).toStringAsFixed(2))),
        TableCell(child: Text(frequency.toStringAsFixed(2))),
        TableCell(
            child: Text((costFactor * amount * frequency).toStringAsFixed(2))),
        TableCell(
            child: Text((costFactor * amount * frequency * timeframeMultiplier)
                .toStringAsFixed(2)))
      ]));
      totalTimeframeCost += costFactor * amount * frequency;
      totalReportCost += costFactor * amount * frequency * timeframeMultiplier;
    }
    returnList.add(TableRow(children: [
      const TableCell(child: Text("")),
      const TableCell(child: Text("")),
      const TableCell(child: Text("")),
      const TableCell(child: Text("")),
      const TableCell(child: Text("")),
      const TableCell(child: Text("")),
      TableCell(
          child: Text(
        totalTimeframeCost.toStringAsFixed(2),
        style: const TextStyle(fontWeight: FontWeight.bold),
      )),
      TableCell(
          child: Text(
        totalReportCost.toStringAsFixed(2),
        style: const TextStyle(fontWeight: FontWeight.bold),
      ))
    ]));
    return returnList;
  }
}
