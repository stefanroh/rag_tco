import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rag_tco/components/provider_selector.dart';
import 'package:rag_tco/data_model/provider_information.dart';
import 'package:rag_tco/misc/provider.dart';

class ServiceEntryAdd extends ConsumerStatefulWidget {
  const ServiceEntryAdd({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => ServiceEntryAddState();
}

class ServiceEntryAddState extends ConsumerState {
  List<TextEditingController> controllerList = [];
  int selectedProviderIndex = 0;

  TextEditingController addController() {
    TextEditingController addedController = TextEditingController();
    controllerList.add(addedController);
    return addedController;
  }

  @override
  Widget build(BuildContext context) {
    AsyncValue<ProviderInformation> asyncProviderInformation =
        ref.watch(providerInformationProvider);

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
        content: Column(children: [
          ProviderSelector(onSelect: (val) {
            setState(() {
              log(val.toString());
              if (selectedProviderIndex != val) {
                controllerList = [];
              }
              selectedProviderIndex = val;
            });
          }),
          switch (asyncProviderInformation) {
            AsyncData(:final value) => Column(children: [
                for (int i = 0;
                    i <
                        value.serviceComponentNames[selectedProviderIndex]
                            .length;
                    i++)
                  SizedBox(
                    width: 200,
                    child: TextField(
                      controller: addController(),
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^(\d+)?\.?\d{0,2}'))
                      ],
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: value
                              .serviceComponentNames[selectedProviderIndex][i]),
                    ),
                  )
              ]),
            AsyncError(:final error) => Text("$error"),
            _ => const Text("Loading"),
          },
          TextButton(
              onPressed: () {
                ref
                    .read(dataStorageProvider.notifier)
                    .addServiceEntry(selectedProviderIndex, getAddedAmounts());
                Navigator.pop(context);
              },
              child: const Text("Add Entry"))
        ]));
  }

  List<double> getAddedAmounts() {
    List<double> returnList = [];
    for (int i = 0; i < controllerList.length; i++) {
      log(controllerList[i].text);
      returnList.add(double.parse(controllerList[i].text));
    }
    return returnList;
  }
}
