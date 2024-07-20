import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rag_tco/components/button.dart';
import 'package:rag_tco/data_model/provider_information.dart';
import 'package:rag_tco/misc/provider.dart';

class ProviderEditDialog extends ConsumerStatefulWidget {
  const ProviderEditDialog({super.key, required this.providerIndex});

  final int providerIndex;

  @override
  ConsumerState createState() => _ProviderEditDialogState();
}

class _ProviderEditDialogState extends ConsumerState<ProviderEditDialog> {
  @override
  Widget build(BuildContext context) {
    AsyncValue<ProviderInformation> asyncProviderInformation =
        ref.watch(providerInformationProvider);

    TextEditingController componentNameController = TextEditingController();
    TextEditingController componentPriceController = TextEditingController();
    TextEditingController componentUnitController = TextEditingController();
    TextEditingController componentAmountController = TextEditingController();

    return AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            switch (asyncProviderInformation) {
              AsyncData(:final value) =>
                Text(value.serviceName[widget.providerIndex]),
              AsyncError(:final error) => Text("$error"),
              _ => const Text("Loading")
            },
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              switch (asyncProviderInformation) {
                AsyncData(:final value) => SizedBox(
                    width: 750,
                    child: Table(
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
                                child: Text("Component Name"),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("Component Price"),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("Reference Amount"),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("Component Unit"),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("Remove"),
                              ))
                            ]),
                        //
                        //Component Data
                        //
                        for (var i = 0;
                            i <
                                value
                                    .serviceComponentNames[widget.providerIndex]
                                    .length;
                            i++)
                          TableRow(children: [
                            TableCell(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(value.serviceComponentNames[
                                  widget.providerIndex][i]),
                            )),
                            TableCell(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(value
                                  .serviceComponentPrices[widget.providerIndex]
                                      [i]
                                  .toString()),
                            )),
                            TableCell(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(value
                                  .serviceComponentAmounts[widget.providerIndex]
                                      [i]
                                  .toString()),
                            )),
                            TableCell(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(ProviderInformation.getUnitTypeString(
                                  value.serviceComponentUnits[
                                      widget.providerIndex][i])),
                            )),
                            TableCell(
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Button(
                                      text: "Remove",
                                      onPressed: () {
                                        ref
                                            .read(providerInformationProvider
                                                .notifier)
                                            .removeServiceComponent(
                                                widget.providerIndex, i);
                                        ref
                                            .read(dataStorageProvider.notifier)
                                            .removeServiceComponent(
                                                widget.providerIndex, i);
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
                                      controller: componentNameController,
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: "Name"),
                                    ),
                                  ))),
                          TableCell(
                            child: Container(
                                margin: const EdgeInsets.all(10),
                                child: SizedBox(
                                  width: 200,
                                  child: TextField(
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                            decimal: true),
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'^(\d+)?\.?\d{0,10}'))
                                    ],
                                    controller: componentPriceController,
                                    decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: "Price"),
                                  ),
                                )),
                          ),
                          TableCell(
                              child: Container(
                            margin: const EdgeInsets.all(10),
                            child: SizedBox(
                              width: 200,
                              child: TextField(
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'^(\d+)?'))
                                ],
                                controller: componentAmountController,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: "Ref. Amount"),
                              ),
                            ),
                          )),
                          TableCell(
                              child: Container(
                            margin: const EdgeInsets.all(10),
                            child: SizedBox(
                              width: 200,
                              child: TextField(
                                controller: componentUnitController,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: "Unit"),
                              ),
                            ),
                          )),
                          TableCell(
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Button(
                                  onPressed: () {
                                    if (componentNameController.text != "" &&
                                        componentPriceController.text != "" &&
                                        componentAmountController.text != "" &&
                                        componentUnitController.text != "") {
                                      ref
                                          .read(providerInformationProvider
                                              .notifier)
                                          .addServiceComponent(
                                              widget.providerIndex,
                                              componentNameController.text,
                                              double.parse(
                                                  componentPriceController
                                                      .text),
                                              ProviderInformation
                                                  .getUnitTypeEnum(
                                                      componentUnitController
                                                          .text),
                                              int.parse(
                                                  componentAmountController
                                                      .text));
                                      ref
                                          .read(dataStorageProvider.notifier)
                                          .addServiceComponent(
                                              widget.providerIndex);
                                    }
                                  },
                                  text: "Add Component",
                                )),
                          )
                        ]),
                      ],
                    ),
                  ),
                AsyncError(:final error) => Text("$error"),
                _ => const Text("Loading")
              },
            ]));
  }
}
