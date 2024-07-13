import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rag_tco/data_model/provider_information.dart';
import 'package:rag_tco/misc/provider.dart';

class ProviderDialog extends ConsumerWidget {
  const ProviderDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<ProviderInformation> asyncProviderInformation =
        ref.watch(providerInformationProvider);

    TextEditingController providerPriceController = TextEditingController();
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
        content: Column(mainAxisSize: MainAxisSize.min, children: [
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
                          child: Text("Price"),
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
                        child: Text(value.servicePrices[i].toString()),
                      )),
                    ])
                ],
              ),
            AsyncError(:final error) => Text("$error"),
            _ => const Center(child: CircularProgressIndicator()),
          },
          const SizedBox(
            height: 50,
          ),
          Row(
            children: [
              SizedBox(
                width: 200,
                child: TextField(
                  controller: providerNameController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: "Add Name"),
                ),
              ),
              const SizedBox(
                width: 50,
              ),
              SizedBox(
                width: 200,
                child: TextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^(\d+)?\.?\d{0,2}'))
                  ],
                  controller: providerPriceController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: "Add Price"),
                ),
              ),
            ],
          ),
          TextButton(
            onPressed: () {
              ref.read(providerInformationProvider.notifier).addServicePrice(
                  providerNameController.text,
                  double.parse(providerPriceController.text));
            },
            child: const Text("Add Price"),
          )
        ]));
  }
}
