import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rag_tco/components/button.dart';
import 'package:rag_tco/data_model/data_storage.dart';
import 'package:rag_tco/data_model/provider_information.dart';
import 'package:rag_tco/misc/provider.dart';

class ServiceEntryEdit extends ConsumerWidget {
  ServiceEntryEdit({super.key, required this.serviceEntriesIndex});

  final int serviceEntriesIndex;
  final List<TextEditingController> controllerList = [];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DataStorage dataStorage = ref.watch(dataStorageProvider);
    AsyncValue<ProviderInformation> asyncProviderInformation =
        ref.watch(providerInformationProvider);

    log(serviceEntriesIndex.toString());

    return AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Edit Service Cost Entry"),
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.clear),
            ),
          ],
        ),
        content: switch (asyncProviderInformation) {
          AsyncData(:final value) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                for (int i = 0;
                    i <
                        value
                            .serviceComponentAmounts[dataStorage
                                .serviceEntries[serviceEntriesIndex]
                                .getProviderReference()]
                            .length;
                    i++)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 250,
                          child: Text(
                            value.serviceComponentNames[dataStorage
                                .serviceEntries[serviceEntriesIndex]
                                .getProviderReference()][i],
                            style: const TextStyle(fontSize: 15),
                          ),
                        ),
                        SizedBox(
                          width: 250,
                          child: TextField(
                            controller: addController(dataStorage
                                .serviceEntries[serviceEntriesIndex]
                                .getAmount(i)
                                .toString()),
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^(\d+)?\.?\d{0,2}'))
                            ],
                            decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                hintText: value.serviceComponentNames[
                                    dataStorage
                                        .serviceEntries[serviceEntriesIndex]
                                        .getProviderReference()][i]),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          width: 100,
                          child: Text(
                            ProviderInformation.getUnitTypeString(
                                value.serviceComponentUnits[dataStorage
                                    .serviceEntries[serviceEntriesIndex]
                                    .getProviderReference()][i]),
                            style: const TextStyle(fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                Button(
                    onPressed: () {
                      if (!hasControllerListEmptyValues()) {
                        ref
                            .read(dataStorageProvider.notifier)
                            .updateServiceAmounts(
                                serviceEntriesIndex, generateAmounts());
                        Navigator.pop(context);
                      }
                    },
                    text: "Save")
              ],
            ),
          AsyncError(:final error) => Text("$error"),
          _ => const Text("Loading")
        });
  }

  TextEditingController addController(String value) {
    TextEditingController newController = TextEditingController(text: value);
    controllerList.add(newController);
    return newController;
  }

  List<double> generateAmounts() {
    List<double> returnList = [];
    for (int i = 0; i < controllerList.length; i++) {
      returnList.add(double.parse(controllerList[i].text));
    }
    return returnList;
  }

  bool hasControllerListEmptyValues() {
    for (TextEditingController controller in controllerList) {
      if (controller.text == "") return true;
    }
    return false;
  }
}
