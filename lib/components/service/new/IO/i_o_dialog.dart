import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rag_tco/components/button.dart';
import 'package:rag_tco/components/service/new/IO/i_o_storage.dart';
import 'package:rag_tco/misc/language_model_price_component_types.dart';

class IODialog extends StatefulWidget {
  const IODialog({super.key, required this.storage});

  final IOStorage storage;
  @override
  State<IODialog> createState() => _IODialogState();
}

class _IODialogState extends State<IODialog> {
  List<TextEditingController> inputController = [];
  List<TextEditingController> outputController = [];
  @override
  Widget build(BuildContext context) {
    generateController();
    return AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Set Input / Output"),
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
            Column(
              children: [
                const Text("Input"),
                for (LanguageModelPriceComponentTypes type
                    in LanguageModelPriceComponentTypes.values)
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: getElement(type, true),
                  ),
                const Divider(),
                const Text("Output"),
                for (LanguageModelPriceComponentTypes type
                    in LanguageModelPriceComponentTypes.values)
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: getElement(type, false),
                  ),
                Button(
                  text: "Save",
                  onPressed: () {
                    for (int i = 0; i < inputController.length; i++) {
                      if (inputController[i].text != "") {
                        widget.storage.setComponent(
                            LanguageModelPriceComponentTypes.values[i],
                            true,
                            double.parse(inputController[i].text));
                      } else {
                        widget.storage.removeComponent(
                            LanguageModelPriceComponentTypes.values[i], true);
                      }
                    }
                    for (int i = 0; i < outputController.length; i++) {
                      if (outputController[i].text != "") {
                        widget.storage.setComponent(
                            LanguageModelPriceComponentTypes.values[i],
                            false,
                            double.parse(outputController[i].text));
                      } else {
                        widget.storage.removeComponent(
                            LanguageModelPriceComponentTypes.values[i], false);
                      }
                    }
                    Navigator.pop(context);
                  },
                )
              ],
            )
          ],
        ));
  }

  Row getElement(LanguageModelPriceComponentTypes type, bool isInput) {
    if (type == LanguageModelPriceComponentTypes.unknown) return const Row();

    return Row(
      children: [
        SizedBox(
          width: 200,
          child: Text(type.parseToString()),
        ),
        SizedBox(
            width: 200,
            child: TextField(
                decoration: const InputDecoration(border: OutlineInputBorder()),
                controller: getController(type, isInput),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: false),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?'))
                ]))
      ],
    );
  }

  void generateController() {
    for (LanguageModelPriceComponentTypes type
        in LanguageModelPriceComponentTypes.values) {
      if (type != LanguageModelPriceComponentTypes.unknown) {
        double inputAmount = widget.storage.getAmountByType(type, true);
        double outputAmount = widget.storage.getAmountByType(type, false);
        inputController.add(TextEditingController(
            text: inputAmount != 0 ? inputAmount.toString() : ""));
        outputController.add(TextEditingController(
            text: outputAmount != 0 ? outputAmount.toString() : ""));
      }
    }
  }

  TextEditingController getController(
      LanguageModelPriceComponentTypes type, bool isInput) {
    List<TextEditingController> controllerList =
        isInput ? inputController : outputController;

    return controllerList[type.index];
  }
}
