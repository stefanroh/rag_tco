import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rag_tco/components/button.dart';

class VariableDialog extends StatefulWidget {
  VariableDialog(BuildContext context,
      {super.key, required this.variableStorage});

  final Map<String, dynamic> variableStorage;
  final List<TextEditingController> controllerList = [];
  final Map<String, TextEditingController> controller =
      <String, TextEditingController>{};

  @override
  State<StatefulWidget> createState() => _VariableDialogState();
}

class _VariableDialogState extends State<VariableDialog> {
  TextEditingController newDescriptionController = TextEditingController();
  TextEditingController newValueController = TextEditingController();
  late Map<String, dynamic> variables;

  @override
  void initState() {
    variables = Map<String, dynamic>.from(widget.variableStorage);
    generateController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Variables"),
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.clear),
            ),
          ],
        ),
        content: SingleChildScrollView(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
          for (String key in variables.keys)
            getRow(key, variables[key].toString()),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Row(children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: SizedBox(
                      width: 250,
                      child: TextField(
                        controller: newDescriptionController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Variable Name"),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: SizedBox(
                    width: 250,
                    child: TextField(
                      controller: newValueController,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^(\d+)?\.?\d{0,10}'))
                      ],
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), hintText: "Value"),
                    ),
                  ),
                ),
                Button(
                    text: 'Add',
                    onPressed: () {
                      if (newDescriptionController.text != "") {
                        setState(() {
                          variables[newDescriptionController.text] =
                              newValueController.text;
                          widget.controller[newDescriptionController.text] =
                              TextEditingController(
                                  text: newValueController.text);
                          newDescriptionController.text = "";
                          newValueController.text = "";
                        });
                      }
                    }),
              ])),
          Button(
              text: "Save",
              onPressed: () {
                widget.variableStorage.clear();
                for (String key in variables.keys) {
                  widget.variableStorage[key] = widget.controller[key]!.text;
                }
                Navigator.pop(context);
              })
        ])));
  }

  void generateController() {
    for (String key in variables.keys) {
      widget.controller[key] = TextEditingController(text: variables[key]);
    }
  }

  Widget getRow(String description, String value) {
    TextEditingController controller = widget.controller[description]!;

    widget.controllerList.add(controller);

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
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^(\d+)?\.?\d{0,10}'))
                ],
                decoration: InputDecoration(
                    border: const OutlineInputBorder(), hintText: description),
                // onTapOutside: (val) {
                //   setState(() {
                //     widget.variableStorage[description] = controller.text;
                //   });
                // },
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Button(
              text: 'Delete',
              onPressed: () {
                setState(() {
                  variables.remove(description);
                });
              }),
        ],
      ),
    );
  }
}
