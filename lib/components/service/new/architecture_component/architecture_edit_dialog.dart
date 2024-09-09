import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rag_tco/components/button.dart';
import 'package:rag_tco/components/service/new/architecture_component/architecture_price_table.dart';
import 'package:rag_tco/data_model/new/architecture_component.dart';
import 'package:rag_tco/misc/provider.dart';

class ArchitectureEditDialog extends ConsumerWidget {
  const ArchitectureEditDialog(this.component, {super.key});
  final ArchitectureComponent component;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController nameController =
        TextEditingController(text: component.componentName);
    TextEditingController fixCostController =
        TextEditingController(text: component.fixCost.toString());

    return AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Edit Architecture Component"),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 3),
                      child: SizedBox(
                        width: 50,
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
                        width: 50,
                        child: Text("Fix Cost"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      child: SizedBox(
                        width: 250,
                        child: TextField(
                          controller: fixCostController,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^(\d+)?\.?\d{0,10}'))
                          ],
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Fix Cost"),
                        ),
                      ),
                    ),
                  ],
                ),
                Button(
                  text: "Save",
                  onPressed: () {
                    if (nameController.text.isNotEmpty) {
                      ref
                          .read(architectureCompnentProvider.notifier)
                          .updateArchitectureComponent(
                              component,
                              nameController.text,
                              fixCostController.text.isNotEmpty
                                  ? double.parse(fixCostController.text)
                                  : 0);
                      Navigator.pop(context);
                    }
                  },
                )
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            SizedBox(
                width: 750,
                height: 500,
                child: SingleChildScrollView(
                  child: ArchitecturePriceTable(component),
                ))
          ],
        ));
  }
}
