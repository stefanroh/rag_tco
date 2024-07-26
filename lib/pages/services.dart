import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rag_tco/components/button.dart';
import 'package:rag_tco/components/provider_dialog.dart';
import 'package:rag_tco/components/service_entry_add.dart';
import 'package:rag_tco/components/service_entry_table.dart';
import 'package:rag_tco/components/service_template_dialog.dart';

class Services extends ConsumerStatefulWidget {
  const Services({super.key});

  @override
  ServicesState createState() => ServicesState();
}

class ServicesState extends ConsumerState<Services> {
  @override
  Widget build(BuildContext context) {
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
            Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Button(
                onPressed: () => _serviceEntryAddDialog(context),
                text: "Add Entry",
              ),
              Button(
                onPressed: () => _providerDialogBuilder(context),
                text: "Edit Service Provider",
              ),
              Button(
                onPressed: () => _serviceTemplateDialog(context),
                text: "Add Cost Template",
              ),
            ]),
            const SizedBox(
              height: 50,
            ),
            const SizedBox(width: 500, child: ServiceEntryTable()),
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

  Future<void> _serviceEntryAddDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return const ServiceEntryAdd();
        });
  }

  Future<void> _serviceTemplateDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return const ServiceTemplateDialog();
        });
  }
}
