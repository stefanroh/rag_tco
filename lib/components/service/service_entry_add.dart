import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rag_tco/components/button.dart';
import 'package:rag_tco/components/service/provider_selector.dart';
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
  TextEditingController entryNameController = TextEditingController();

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
            const Text("Add Service Cost Entry"),
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.clear),
            ),
          ],
        ),
        content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    const SizedBox(
                        width: 250,
                        child: Text("Select Provider",
                            style: TextStyle(fontSize: 15))),
                    ProviderSelector(onSelect: (val) {
                      setState(() {
                        if (selectedProviderIndex != val) {
                          controllerList = [];
                        }
                        selectedProviderIndex = val;
                      });
                    }),
                  ],
                ),
              ),
              switch (asyncProviderInformation) {
                AsyncData(:final value) => Column(children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
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
                                  hintText: "Name"),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    for (int i = 0;
                        i <
                            value.serviceComponentNames[selectedProviderIndex]
                                .length;
                        i++)
                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 250,
                                child: Text(
                                  value.serviceComponentNames[
                                      selectedProviderIndex][i],
                                  style: const TextStyle(fontSize: 15),
                                ),
                              ),
                              SizedBox(
                                width: 250,
                                child: TextField(
                                  controller: addController(),
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                          decimal: true),
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'^(\d+)?\.?\d{0,2}'))
                                  ],
                                  decoration: InputDecoration(
                                      border: const OutlineInputBorder(),
                                      hintText: value.serviceComponentNames[
                                          selectedProviderIndex][i]),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              SizedBox(
                                width: 100,
                                child: Text(
                                  ProviderInformation.getUnitTypeString(
                                      value.serviceComponentUnits[
                                          selectedProviderIndex][i]),
                                  style: const TextStyle(fontSize: 15),
                                ),
                              ),
                            ],
                          )),
                  ]),
                AsyncError(:final error) => Text("$error"),
                _ => const Text("Loading"),
              },
              Button(
                  onPressed: () {
                    if (!hasControllerListEmptyValues()) {
                      ref.read(dataStorageProvider.notifier).addServiceEntry(
                          selectedProviderIndex,
                          getAddedAmounts(),
                          entryNameController.text);
                      Navigator.pop(context);
                    }
                  },
                  text: "Add Entry")
            ]));
  }

  List<double> getAddedAmounts() {
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
