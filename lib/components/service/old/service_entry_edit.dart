import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rag_tco/components/button.dart';
import 'package:rag_tco/components/service/old/timeframe_selector.dart';
import 'package:rag_tco/data_model/old/data_storage.dart';
import 'package:rag_tco/data_model/old/provider_information.dart';
import 'package:rag_tco/data_model/old/timeframe_type.dart';
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
    TextEditingController entryNameController = TextEditingController(
        text: dataStorage.serviceEntries[serviceEntriesIndex].entryName);
    TimeframeType selectedTimeframe =
        dataStorage.serviceEntries[serviceEntriesIndex].referenceTimeframe;
    TextEditingController frequencyController = TextEditingController(
        text: dataStorage.serviceEntries[serviceEntriesIndex].frequency
            .toString());

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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 250,
                        child: Text(
                          "Cost Entry Name",
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                      SizedBox(
                          width: 250,
                          child: TextField(
                            controller: entryNameController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Name",
                            ),
                          )),
                    ],
                  ),
                ),
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
                            ProviderInformation.getUnitTypesLegacytring(
                                value.serviceComponentUnits[dataStorage
                                    .serviceEntries[serviceEntriesIndex]
                                    .getProviderReference()][i]),
                            style: const TextStyle(fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 250,
                        child: Text(
                          "Frequency in timeframe",
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                      SizedBox(
                        width: 250,
                        child: TextField(
                            controller: frequencyController,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Frequency"),
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: false),
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^(\d+)?'))
                            ]),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 250,
                      ),
                      SizedBox(width: 250, child: Text("per")),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 250,
                        child: Text(
                          "Reference timeframe",
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                      SizedBox(
                        width: 250,
                        child: TimeframeSelector(
                          initialTimeframe: selectedTimeframe,
                          onSelect: (val) => selectedTimeframe = val,
                          width: 250,
                        ),
                      ),
                    ],
                  ),
                ),
                Button(
                    onPressed: () {
                      if (!hasControllerListEmptyValues() &&
                          frequencyController.text != "") {
                        ref
                            .read(dataStorageProvider.notifier)
                            .updateServiceEntry(
                                serviceEntriesIndex,
                                generateAmounts(),
                                entryNameController.text,
                                selectedTimeframe,
                                int.parse(frequencyController.text));
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
