import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rag_tco/components/button.dart';
import 'package:rag_tco/components/service/old/provider_edit_dialog.dart';
import 'package:rag_tco/data_model/old/provider_information.dart';
import 'package:rag_tco/data_model/old/unit_types_legacy.dart';
import 'package:rag_tco/misc/provider.dart';

class ProviderDialog extends ConsumerStatefulWidget {
  const ProviderDialog({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => ProviderDialogState();
}

class ProviderDialogState extends ConsumerState<ProviderDialog> {

  @override
  Widget build(BuildContext context) {
    AsyncValue<ProviderInformation> asyncProviderInformation =
        ref.watch(providerInformationProvider);

    TextEditingController providerNameController = TextEditingController();

    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Provider"),
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.clear),
          ),
        ],
      ),
      content: SizedBox(
          height: 700,
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                width: 750,
              ),
              switch (asyncProviderInformation) {
                AsyncData(:final value) => Table(
                      border: TableBorder.all(color: Colors.black),
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      children: [
                        //
                        //Header
                        //
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
                                child: Text("Price Components"),
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
                                ),
                              ),
                            ]),
                        //
                        //Data Information
                        //
                        for (var i = 0; i < value.serviceName.length; i++)
                          TableRow(children: [
                            TableCell(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(value.serviceName[i]),
                            )),
                            TableCell(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(componentStringBuilder(
                                  value.serviceComponentNames[i],
                                  value.serviceComponentPrices[i],
                                  value.serviceComponentAmounts[i],
                                  value.serviceComponentUnits[i])),
                            )),
                            TableCell(
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Button(
                                      text: "Edit",
                                      onPressed: () =>
                                          _providerEditDialog(context, i))),
                            ),
                            TableCell(
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Button(
                                      text: "Remove",
                                      onPressed: () {
                                        ref
                                            .read(dataStorageProvider.notifier)
                                            .removeServiceEntryByProvider(i);
                                        ref
                                            .read(providerInformationProvider
                                                .notifier)
                                            .removeServiceProvider(i);
                                      })),
                            ),
                          ]),
                        //
                        //Add Entry
                        //
                        TableRow(children: [
                          TableCell(
                              child: Container(
                            margin: const EdgeInsets.all(10),
                            child: SizedBox(
                              width: 200,
                              child: TextField(
                                controller: providerNameController,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: "Name"),
                              ),
                            ),
                          )),
                          const TableCell(child: Text("")),
                          const TableCell(child: Text("")),
                          TableCell(
                            child: Container(
                              margin: const EdgeInsets.all(10),
                              child: Button(
                                onPressed: () {
                                  if (providerNameController.text != "") {
                                    ref
                                        .read(providerInformationProvider
                                            .notifier)
                                        .addServiceProvider(
                                            providerNameController.text);
                                  }
                                },
                                text: "Add",
                              ),
                            ),
                          ),
                        ]),
                      ]),
                AsyncError(:final error) => Text("$error"),
                _ => const Center(child: CircularProgressIndicator()),
              },
            ],
          ))),
    );
  }

  String componentStringBuilder(
      List<String> componentNames,
      List<double> componentPrices,
      List<int> componentAmount,
      List<UnitTypesLegacy> componentUnits) {
    String returnString = "";
    for (int i = 0; i < componentNames.length; i++) {
      returnString +=
          "${componentNames[i]}: ${componentPrices[i]} / ${componentAmount[i]} ${ProviderInformation.getUnitTypesLegacytring(componentUnits[i])}";
      //Not last line
      if (i != componentNames.length - 1) returnString += "\n";
    }
    return returnString;
  }

  Future<void> _providerEditDialog(BuildContext context, int providerIndex) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return ProviderEditDialog(
            providerIndex: providerIndex,
          );
        });
  }
}
