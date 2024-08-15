import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rag_tco/components/button.dart';
import 'package:rag_tco/data_model/new/price_component.dart';
import 'package:rag_tco/data_model/new/rag_component_language_model.dart';
import 'package:rag_tco/misc/input_output_selector.dart';
import 'package:rag_tco/misc/language_model_price_component_selector.dart';
import 'package:rag_tco/misc/language_model_price_component_types.dart';
import 'package:rag_tco/misc/provider.dart';

class LanguageModelComponentTable extends ConsumerStatefulWidget {
  const LanguageModelComponentTable({super.key, required this.model});

  final RagComponentLanguageModel model;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _LanguageModelComponentTableState();
}

class _LanguageModelComponentTableState
    extends ConsumerState<LanguageModelComponentTable> {
  final TextEditingController priceController = TextEditingController();
  final TextEditingController refAmountController = TextEditingController();
  bool selectedInput = true;
  LanguageModelPriceComponentTypes selectedComponentType =
      LanguageModelPriceComponentTypes.unknown;


  @override
  Widget build(BuildContext context) {
    List<DropdownMenuEntry<bool>> inputOutputEntires =
        getInputOutputMenuEntries();
    //Current selected option is not available
    if (inputOutputEntires.isNotEmpty &&
        !inputOutputEntires
            .map((element) => element.value)
            .toList()
            .contains(selectedInput)) {
      selectedInput = inputOutputEntires[0].value;
    }
    List<DropdownMenuEntry<LanguageModelPriceComponentTypes>>
        componentTypeEntries = getComponenTypeEntries();
    if (componentTypeEntries.isNotEmpty &&
        !componentTypeEntries
            .map((element) => element.value)
            .toList()
            .contains(selectedComponentType)) {
      selectedComponentType = componentTypeEntries[0].value;
    }
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
                child: Text("Input / Output"),
              )),
              TableCell(
                  child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Type"),
              )),
              TableCell(
                  child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Price"),
              )),
              TableCell(
                  child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Reference Amount"),
              )),
              TableCell(
                child: Padding(
                    padding: EdgeInsets.all(8.0), child: Text("Remove")),
              )
            ]),
        for (PriceComponent priceComponent in widget.model.priceComponents)
          TableRow(children: [
            TableCell(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(priceComponent.isInput ? "Input" : "Output"),
            )),
            TableCell(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(priceComponent.type.parseToString()),
            )),
            TableCell(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(priceComponent.price.toString()),
            )),
            TableCell(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(priceComponent.referenceAmount.toString()),
            )),
            TableCell(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Button(
                    text: "Remove",
                    onPressed: () {
                      ref
                          .read(ragComponentsProvider.notifier)
                          .removeLanguageModelComponent(
                              widget.model, priceComponent);
                      setState(() {});
                    },
                  )),
            ),
          ]),
        if (inputOutputEntires.isNotEmpty)
          TableRow(children: [
            TableCell(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InputOutputSelector(
                initialSelection: selectedInput,
                width: 135,
                onSelect: (val) => setState(() {
                  selectedInput = val;
                }),
                entries: getInputOutputMenuEntries(),
              ),
            )),
            TableCell(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: LanguageModelPriceComponentSelector(
                  entries: componentTypeEntries,
                  width: 135,
                  initialSelection: selectedComponentType,
                  onSelect: (val) => setState(() {
                        selectedComponentType = val!;
                      })),
            )),
            TableCell(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: priceController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^(\d+)?\.?\d{0,2}'))
                  ],
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: "Price"),
                ),
              ),
            ),
            TableCell(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: refAmountController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^(\d+)?\.?\d{0,2}'))
                  ],
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Reference Amount"),
                ),
              ),
            ),
            TableCell(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Button(
                  text: "Add",
                  onPressed: () {
                    if (priceController.text != "" &&
                        refAmountController.text != "") {
                      ref
                          .read(ragComponentsProvider.notifier)
                          .addLanguageModelComponent(
                              widget.model,
                              PriceComponent(
                                  isInput: selectedInput,
                                  type: selectedComponentType,
                                  price: double.parse(priceController.text),
                                  referenceAmount:
                                      double.parse(refAmountController.text)));
                      setState(() {});
                      priceController.text = "";
                      refAmountController.text = "";
                    }
                  }),
            ))
          ])
      ],
    );
  }

  List<DropdownMenuEntry<bool>> getInputOutputMenuEntries() {
    List<DropdownMenuEntry<bool>> returnList = [];
    List<PriceComponent> componentList =
        List<PriceComponent>.from(widget.model.priceComponents);

    List<PriceComponent> trueList =
        componentList.where((element) => element.isInput == true).toList();
    List<PriceComponent> falseList =
        componentList.where((element) => element.isInput == false).toList();

    if (trueList.length < LanguageModelPriceComponentTypes.values.length - 1) {
      returnList.add(const DropdownMenuEntry(value: true, label: "Input"));
    }
    if (falseList.length < LanguageModelPriceComponentTypes.values.length - 1) {
      returnList.add(const DropdownMenuEntry(value: false, label: "Output"));
    }

    return returnList;
  }

  List<DropdownMenuEntry<LanguageModelPriceComponentTypes>>
      getComponenTypeEntries() {
    List<PriceComponent> componentList =
        List<PriceComponent>.from(widget.model.priceComponents);
    List<LanguageModelPriceComponentTypes> typeList =
        LanguageModelPriceComponentTypes.values.toList();
    componentList = componentList
        .where((element) => element.isInput == selectedInput)
        .toList();
    for (PriceComponent component in componentList) {
      typeList.removeWhere((element) => element == component.type);
    }
    typeList.removeWhere(
        (element) => element == LanguageModelPriceComponentTypes.unknown);
    return typeList
        .map((element) =>
            DropdownMenuEntry(value: element, label: element.parseToString()))
        .toList();
  }
}
