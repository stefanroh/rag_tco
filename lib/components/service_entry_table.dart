import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rag_tco/data_model/data_storage.dart';
import 'package:rag_tco/data_model/provider_information.dart';
import 'package:rag_tco/misc/provider.dart';

class ServiceEntryTable extends ConsumerWidget {
  const ServiceEntryTable({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<ProviderInformation> asyncProviderInformation =
        ref.watch(providerInformationProvider);
    DataStorage dataStorage = ref.watch(dataStorageProvider);

    return switch (asyncProviderInformation) {
      AsyncData(:final value) => Table(
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
                    child: Text("Price"),
                  )),
                  TableCell(
                      child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Amount"),
                  ))
                ]),
            for (var i = 0; i < dataStorage.serviceAmounts.length; i++)
              TableRow(children: [
                TableCell(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(value
                      .serviceName[dataStorage.serviceProviderReferences[i]]),
                )),
                TableCell(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(value
                      .servicePrices[dataStorage.serviceProviderReferences[i]]
                      .toString()),
                )),
                TableCell(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(dataStorage.serviceAmounts[i].toString()),
                )),
              ])
          ],
        ),
      AsyncError(:final error) => Text("$error"),
      _ => const Center(child: CircularProgressIndicator()),
    };
  }
}
