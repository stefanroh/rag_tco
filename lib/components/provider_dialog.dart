import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rag_tco/components/provider_edit_dialog.dart';
import 'package:rag_tco/data_model/provider_information.dart';
import 'package:rag_tco/misc/provider.dart';

class ProviderDialog extends ConsumerStatefulWidget {
  const ProviderDialog({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => ProviderDialogState();
}

class ProviderDialogState extends ConsumerState<ProviderDialog> {
  int selectedIndex = 0;

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
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            width: 500,
          ),
          switch (asyncProviderInformation) {
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
                          child: Text("Price Components"),
                        )),
                        TableCell(
                            child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Edit"),
                        )),
                      ]),
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
                            value.serviceComponentUnits[i])),
                      )),
                      TableCell(
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextButton(
                                child: const Text("Edit"),
                                onPressed: () =>
                                    _providerEditDialog(context, i))),
                      ),
                    ])
                ],
              ),
            AsyncError(:final error) => Text("$error"),
            _ => const Center(child: CircularProgressIndicator()),
          },
          const SizedBox(
            height: 50,
          ),
          Row(children: [
            SizedBox(
              width: 200,
              child: TextField(
                controller: providerNameController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: "Add Name"),
              ),
            ),
            TextButton(
              onPressed: () {
                ref
                    .read(providerInformationProvider.notifier)
                    .addServiceProvider(providerNameController.text);
              },
              child: const Text("Add Provider"),
            ),
          ]),
        ],
      ),
    );
  }

  String componentStringBuilder(List<String> componentNames,
      List<double> componentPrices, List<String> componentUnits) {
    String returnString = "";
    for (int i = 0; i < componentNames.length; i++) {
      returnString +=
          "${componentNames[i]}: ${componentPrices[i]} / ${componentUnits[i]}";
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
