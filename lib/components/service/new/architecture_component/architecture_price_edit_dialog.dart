import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rag_tco/components/button.dart';
import 'package:rag_tco/data_model/new/variable_price_component.dart';
import 'package:rag_tco/misc/full_unit_selector.dart';
import 'package:rag_tco/misc/provider.dart';

class ArchitecturePriceEditDialog extends ConsumerStatefulWidget {
  const ArchitecturePriceEditDialog(this.priceComponent, {super.key});

  final VariablePriceComponent priceComponent;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ArchitecturePriceEditDialogState();
}

class _ArchitecturePriceEditDialogState
    extends ConsumerState<ArchitecturePriceEditDialog> {
  late bool onlyFullUnits;

  @override
  void initState() {
    onlyFullUnits = widget.priceComponent.onlyFullAmounts;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController =
        TextEditingController(text: widget.priceComponent.name);
    TextEditingController referenceAmountController = TextEditingController(
        text: widget.priceComponent.referenceAmount.toString());
    TextEditingController priceController =
        TextEditingController(text: widget.priceComponent.price.toString());
    TextEditingController inclusiveAmountController = TextEditingController(
        text: widget.priceComponent.inclusiveAmount.toString());
    TextEditingController minAmountController =
        TextEditingController(text: widget.priceComponent.minAmount.toString());
    TextEditingController formularController =
        TextEditingController(text: widget.priceComponent.quantityFormular);

    return AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Edit Architecture Pricecomponent"),
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
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 3),
                  child: SizedBox(
                    width: 250,
                    child: Text("Name"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: SizedBox(
                    width: 250,
                    child: TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), hintText: "Name"),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 3),
                  child: SizedBox(
                    width: 250,
                    child: Text("Price"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: SizedBox(
                    width: 250,
                    child: TextField(
                      controller: priceController,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^(\d+)?\.?\d{0,10}'))
                      ],
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), hintText: "Price"),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 3),
                  child: SizedBox(
                    width: 250,
                    child: Text("Reference Amount"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: SizedBox(
                    width: 250,
                    child: TextField(
                      controller: referenceAmountController,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^(\d+)?\.?\d{0,10}'))
                      ],
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Reference Amount"),
                    ),
                  ),
                ),
              ],
            ),
            const Divider(),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 3),
                  child: SizedBox(
                    width: 250,
                    child: Text("Only full Units"),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: FullUnitSelector(250, onlyFullUnits,
                        (selection) => onlyFullUnits = selection)),
              ],
            ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 3),
                  child: SizedBox(
                    width: 250,
                    child: Text("Inclusive Amount"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: SizedBox(
                    width: 250,
                    child: TextField(
                      controller: inclusiveAmountController,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^(\d+)?\.?\d{0,10}'))
                      ],
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Inclusive Amount"),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 3),
                  child: SizedBox(
                    width: 250,
                    child: Text("Minimum Amount"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: SizedBox(
                    width: 250,
                    child: TextField(
                      controller: minAmountController,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^(\d+)?\.?\d{0,10}'))
                      ],
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Minimum Amount"),
                    ),
                  ),
                ),
              ],
            ),
            const Divider(),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 3),
                  child: SizedBox(
                    width: 250,
                    child: Text("Quantity Formular"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: SizedBox(
                    width: 250,
                    child: TextField(
                      controller: formularController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Quantity Formular"),
                    ),
                  ),
                ),
              ],
            ),
            Button(
                text: "Save",
                onPressed: () {
                  if (nameController.text != "") {
                    ref
                        .read(architectureCompnentProvider.notifier)
                        .updateVariablePriceComponent(widget.priceComponent,
                            newName: nameController.text,
                            newPrice: priceController.text.isNotEmpty
                                ? double.parse(priceController.text)
                                : 0,
                            newInclusiveAmount: inclusiveAmountController
                                    .text.isNotEmpty
                                ? double.parse(inclusiveAmountController.text)
                                : 0,
                            newMinAmount: minAmountController.text.isNotEmpty
                                ? double.parse(minAmountController.text)
                                : 0,
                            newOnlyFullUnit: onlyFullUnits,
                            newFormular: formularController.text);
                    Navigator.pop(context);
                  }
                })
          ],
        ));
  }
}
