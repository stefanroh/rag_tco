import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rag_tco/components/button.dart';
import 'package:rag_tco/components/service/new/architecture_component/architecture_price_edit_dialog.dart';
import 'package:rag_tco/data_model/new/architecture_component.dart';
import 'package:rag_tco/data_model/new/architecture_components_storage.dart';
import 'package:rag_tco/data_model/new/variable_price_component.dart';
import 'package:rag_tco/misc/provider.dart';

class ArchitecturePriceTable extends ConsumerWidget {
  const ArchitecturePriceTable(this.component, {super.key});

  final ArchitectureComponent component;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController nameController = TextEditingController();

    // ignore: unused_local_variable
    AsyncValue<ArchitectureComponentsStorage> storage =
        ref.watch(architectureComponentProvider);

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
        for (VariablePriceComponent priceComponent
            in component.variablePriceComponents)
          TableRow(children: [
            TableCell(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(priceComponent.name),
            )),
            TableCell(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(getConfigurationString(priceComponent)),
            )),
            TableCell(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Button(
                  text: "Edit",
                  onPressed: () =>
                      _architecturePriceEditDialog(context, priceComponent)),
            )),
            TableCell(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Button(
                  text: "Remove",
                  onPressed: () => (ref
                      .read(architectureComponentProvider.notifier)
                      .removeVariablePriceComponent(
                          component, priceComponent))),
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
                      .addVariablePriceComponent(
                          component,
                          VariablePriceComponent(
                              nameController.text, 0, 1, false, 0, 0, ""));
                }
              },
            ),
          ))
        ])
      ],
    );
  }
}

String getConfigurationString(VariablePriceComponent priceComponent) {
  return "${priceComponent.name}: ${priceComponent.price.toString()}€ / ${priceComponent.referenceAmount.toString()} \n(min ${priceComponent.minAmount}, inclusive ${priceComponent.inclusiveAmount})\n";
}

Future<void> _architecturePriceEditDialog(
    BuildContext context, VariablePriceComponent priceComponent) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return ArchitecturePriceEditDialog(priceComponent);
      });
}
