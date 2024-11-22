import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rag_tco/components/button.dart';
import 'package:rag_tco/components/architecture_component/architecture_edit_dialog.dart';
import 'package:rag_tco/data_model/architecture_component.dart';
import 'package:rag_tco/data_model/architecture_components_storage.dart';
import 'package:rag_tco/data_model/variable_price_component.dart';

import 'package:rag_tco/misc/provider.dart';

class ArchitectureTable extends ConsumerWidget {
  const ArchitectureTable({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<ArchitectureComponentsStorage> asyncComponentStorage =
        ref.watch(architectureComponentProvider);

    TextEditingController nameController = TextEditingController();
    switch (asyncComponentStorage) {
      case AsyncData(:final value):
        return Table(
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
                    child: Text("Configuration"),
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
                  ))
                ]),
            for (ArchitectureComponent component in value.componentList)
              TableRow(children: [
                TableCell(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(component.componentName),
                )),
                TableCell(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(getConfigurationString(component)),
                )),
                TableCell(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Button(
                      text: "Edit",
                      onPressed: () =>
                          _architectureEditDialog(context, component)),
                )),
                TableCell(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Button(
                      text: "Remove",
                      onPressed: () => (ref
                          .read(architectureComponentProvider.notifier)
                          .removeArchitectureComponent(component))),
                ))
              ]),
            TableRow(children: [
              TableCell(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: "Name"),
                  controller: nameController,
                ),
              )),
              const TableCell(child: Text("")),
              const TableCell(child: Text("")),
              TableCell(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Button(
                  text: "Add",
                  onPressed: () {
                    if (nameController.text != "") {
                      ref
                          .read(architectureComponentProvider.notifier)
                          .addArchitectureComponent(ArchitectureComponent(
                              nameController.text, 0, "€", "N/A", "N/A"));
                    }
                  },
                ),
              ))
            ])
          ],
        );
      case AsyncError(:final error):
        return Text("$error");
      default:
        return const Text("Loading");
    }
  }

  Future<void> _architectureEditDialog(
      BuildContext context, ArchitectureComponent component) {
    return showDialog(
        context: context,
        barrierColor: const Color(0x01000000),
        builder: (BuildContext context) {
          return ArchitectureEditDialog(component);
        });
  }

  String getConfigurationString(ArchitectureComponent component) {
    String returnString = "Fix Cost: ${component.fixCost.toString()}\n";
    for (VariablePriceComponent priceComponent
        in component.variablePriceComponents) {
      returnString +=
          "${priceComponent.name}: ${priceComponent.price.toString()}${component.currency} / ${priceComponent.referenceAmount.toString()}\n";
    }
    return returnString.substring(0, returnString.length - 1);
  }
}
