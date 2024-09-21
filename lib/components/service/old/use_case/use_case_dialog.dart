import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rag_tco/components/button.dart';
import 'package:rag_tco/components/service/old/use_case/use_case_storage.dart';
import 'package:rag_tco/misc/language_model_price_component_types.dart';

class UseCaseDialog extends StatefulWidget {
  const UseCaseDialog({super.key, required this.storage});

  final UseCaseStorage storage;
  @override
  State<UseCaseDialog> createState() => _IODialogState();
}

class _IODialogState extends State<UseCaseDialog> {
  List<TextEditingController> inputController = [];
  List<TextEditingController> outputController = [];
  TextEditingController storageController = TextEditingController();
  TextEditingController vectorDBController = TextEditingController();
  TextEditingController preprocessorController = TextEditingController();
  TextEditingController frequencyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    generateController();
    loadOtherSettings();
    return AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Use Case Settings"),
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.clear),
            ),
          ],
        ),
        content: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("LLM Input"),
                    for (LanguageModelPriceComponentTypes type
                        in LanguageModelPriceComponentTypes.values)
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: getIOElement(type, true),
                      ),
                    const Text("LLM Output"),
                    for (LanguageModelPriceComponentTypes type
                        in LanguageModelPriceComponentTypes.values)
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: getIOElement(type, false),
                      ),
                    Button(
                      text: "Save",
                      onPressed: () {
                        saveData();
                        Navigator.pop(context);
                      },
                    )
                  ],
                )
              ],
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Other Settings"),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 200,
                        child: Text("Frequency"),
                      ),
                      SizedBox(
                          width: 200,
                          child: TextField(
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder()),
                              controller: frequencyController,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: false),
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^(\d+)?'))
                              ]))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 200,
                        child: Text("Storage Amount"),
                      ),
                      SizedBox(
                          width: 200,
                          child: TextField(
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder()),
                              controller: storageController,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: false),
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^(\d+)?'))
                              ]))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 200,
                        child: Text("VectorDB Updates"),
                      ),
                      SizedBox(
                          width: 200,
                          child: TextField(
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder()),
                              controller: vectorDBController,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: false),
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^(\d+)?'))
                              ]))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 200,
                        child: Text("Preprocessor Operations"),
                      ),
                      SizedBox(
                          width: 200,
                          child: TextField(
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder()),
                              controller: preprocessorController,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: false),
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^(\d+)?'))
                              ]))
                    ],
                  ),
                )
              ],
            )
          ],
        ));
  }

  Row getIOElement(LanguageModelPriceComponentTypes type, bool isInput) {
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
        int inputAmount = widget.storage.getAmountByType(type, true);
        int outputAmount = widget.storage.getAmountByType(type, false);
        inputController.add(TextEditingController(
            text: inputAmount != 0 ? inputAmount.toString() : ""));
        outputController.add(TextEditingController(
            text: outputAmount != 0 ? outputAmount.toString() : ""));
      }
    }
  }

  void loadOtherSettings() {
    frequencyController.text = widget.storage.frequency != 0
        ? widget.storage.frequency.toString()
        : "";
    storageController.text = widget.storage.storageAmount != 0
        ? widget.storage.storageAmount.toString()
        : "";
    vectorDBController.text = widget.storage.vectorDBUpdate != 0
        ? widget.storage.vectorDBUpdate.toString()
        : "";
    preprocessorController.text = widget.storage.preprocessorOperation != 0
        ? widget.storage.preprocessorOperation.toString()
        : "";
  }

  TextEditingController getController(
      LanguageModelPriceComponentTypes type, bool isInput) {
    List<TextEditingController> controllerList =
        isInput ? inputController : outputController;

    return controllerList[type.index];
  }

  void saveData() {
    for (int i = 0; i < inputController.length; i++) {
      if (inputController[i].text != "") {
        widget.storage.setComponent(LanguageModelPriceComponentTypes.values[i],
            true, int.parse(inputController[i].text));
      } else {
        widget.storage
            .removeComponent(LanguageModelPriceComponentTypes.values[i], true);
      }
    }
    for (int i = 0; i < outputController.length; i++) {
      if (outputController[i].text != "") {
        widget.storage.setComponent(LanguageModelPriceComponentTypes.values[i],
            false, int.parse(outputController[i].text));
      } else {
        widget.storage
            .removeComponent(LanguageModelPriceComponentTypes.values[i], false);
      }
    }
    widget.storage.frequency = frequencyController.text.isNotEmpty
        ? int.parse(frequencyController.text)
        : 0;
    widget.storage.storageAmount = storageController.text.isNotEmpty
        ? int.parse(storageController.text)
        : 0;
    widget.storage.vectorDBUpdate = vectorDBController.text.isNotEmpty
        ? int.parse(vectorDBController.text)
        : 0;
    widget.storage.preprocessorOperation =
        preprocessorController.text.isNotEmpty
            ? int.parse(preprocessorController.text)
            : 0;
  }
}
