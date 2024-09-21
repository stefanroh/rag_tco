import 'package:flutter/material.dart';
import 'package:rag_tco/components/button.dart';
import 'package:rag_tco/data_model/new/use_case_storage.dart';

class UseCaseFormularDialog extends StatefulWidget {
  const UseCaseFormularDialog(BuildContext context,
      {super.key, required this.storage, required this.useCaseComponentIndex});

  final UseCaseStorage storage;
  final int useCaseComponentIndex;

  @override
  State<StatefulWidget> createState() => _VariableDialogState();
}

class _VariableDialogState extends State<UseCaseFormularDialog> {
  List<TextEditingController> controllerList = [];

  TextEditingController newDescriptionController = TextEditingController();
  TextEditingController newValueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Formular Edit"),
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.clear),
            ),
          ],
        ),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          for (int i = 0;
              i <
                  widget.storage.components[widget.useCaseComponentIndex]
                      .variablePriceComponents.length;
              i++)
            getRow(i),
          Button(
              text: "Save",
              onPressed: () {
                widget.storage.updateFormulars(widget.useCaseComponentIndex,
                    controllerList.map((element) => element.text).toList());
                Navigator.pop(context);
              })
        ]));
  }

  Widget getRow(int i) {
    String description = widget.storage.components[widget.useCaseComponentIndex]
        .variablePriceComponents[i].name;
    String value = "";
    if (widget.storage.quantityFormulars[widget.useCaseComponentIndex].length >
        i) {
      value = widget.storage.quantityFormulars[widget.useCaseComponentIndex][i];
    }

    TextEditingController controller = TextEditingController(text: value);

    controllerList.add(controller);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: SizedBox(
              width: 250,
              child: Text(description),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: SizedBox(
              width: 250,
              child: TextField(
                controller: controller,
                // keyboardType:
                //     const TextInputType.numberWithOptions(decimal: true),
                // inputFormatters: <TextInputFormatter>[
                //   FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,10}'))
                // ],
                decoration: InputDecoration(
                    border: const OutlineInputBorder(), hintText: description),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
