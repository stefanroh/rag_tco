import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rag_tco/components/provider_dialog.dart';
import 'package:rag_tco/components/provider_selector.dart';
import 'package:rag_tco/components/service_entry_table.dart';
import 'package:rag_tco/data_model/data_storage.dart';
import 'package:rag_tco/data_model/provider_information.dart';
import 'package:rag_tco/misc/provider.dart';

class Services extends ConsumerStatefulWidget {
  const Services({super.key});

  @override
  ServicesState createState() => ServicesState();
}

class ServicesState extends ConsumerState<Services> {
  @override
  Widget build(BuildContext context) {
    AsyncValue<ProviderInformation> asyncProviderInformation =
        ref.watch(providerInformationProvider);
    DataStorage dataStorage = ref.watch(dataStorageProvider);

    TextEditingController providerPriceController = TextEditingController();
    TextEditingController providerNameController = TextEditingController();
    TextEditingController entryAmountController = TextEditingController();

    int selectedIndex = 0;

    ProviderSelector providerSelector =
        ProviderSelector(onSelect: (p0) => selectedIndex = p0);

    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Add Cost Entry",
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),
            // const Text("Add Provider"),
            // SizedBox(
            //   height: 100,
            //   width: 250,
            //   child: TextField(
            //     controller: providerNameController,
            //     decoration: const InputDecoration(
            //         border: OutlineInputBorder(), hintText: "Add Name"),
            //   ),
            // ),
            // const SizedBox(
            //   width: 100,
            // ),
            // SizedBox(
            //   height: 100,
            //   width: 250,
            //   child: TextField(
            //     keyboardType:
            //         const TextInputType.numberWithOptions(decimal: true),
            //     inputFormatters: <TextInputFormatter>[
            //       FilteringTextInputFormatter.allow(
            //           RegExp(r'^(\d+)?\.?\d{0,2}'))
            //     ],
            //     controller: providerPriceController,
            //     decoration: const InputDecoration(
            //         border: OutlineInputBorder(), hintText: "Add Price"),
            //   ),
            // ),
            // TextButton(
            //   onPressed: () {
            //     ref.read(providerInformationProvider.notifier).addServicePrice(
            //         providerNameController.text,
            //         double.parse(providerPriceController.text));
            //   },
            //   child: const Text("Add Price"),
            // ),
            // switch (asyncProviderInformation) {
            //   AsyncData(:final value) => Text(value.servicePrices.toString() +
            //       value.serviceName.toString()),
            //   AsyncError(:final error) => Text('Error: $error'),
            //   _ => const Center(child: CircularProgressIndicator()),
            // },
            Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              providerSelector,
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
                  controller: entryAmountController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: "Add Amount"),
                ),
              ),
              TextButton(
                onPressed: () {
                  ref.read(dataStorageProvider.notifier).addService(
                      selectedIndex, double.parse(entryAmountController.text));
                },
                child: const Text("Add Price"),
              ),
              TextButton(
                onPressed: () => _providerDialogBuilder(context),
                child: const Text("Edit Service Provider"),
              ),
            ]),
            const SizedBox(
              height: 50,
            ),
            const SizedBox(width: 500, child: ServiceEntryTable()),
            switch (asyncProviderInformation) {
              AsyncData(:final value) => Text(
                  value.serviceComponentNames.toString() +
                      value.serviceComponentPrices.toString()),
              AsyncError(:final error) => Text("$error"),
              _ => const Text("Loading")
            }
          ]),
        ]);
  }

  Future<void> _providerDialogBuilder(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return const ProviderDialog();
        });
  }
}
