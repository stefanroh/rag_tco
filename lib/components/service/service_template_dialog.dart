import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rag_tco/components/button.dart';
import 'package:rag_tco/components/service/provider_selector.dart';
import 'package:rag_tco/data_model/provider_information.dart';
import 'package:rag_tco/data_model/service_template.dart';
import 'package:rag_tco/data_model/unit_types.dart';
import 'package:rag_tco/misc/provider.dart';

class ServiceTemplateDialog extends ConsumerStatefulWidget {
  const ServiceTemplateDialog({super.key});

  @override
  ConsumerState<ServiceTemplateDialog> createState() =>
      _ServiceTemplateDialogState();
}

class _ServiceTemplateDialogState extends ConsumerState<ServiceTemplateDialog> {
  List<ServiceTemplate> templateList = [];
  List<bool> selectedEntries = [];
  int selectedProvider = 0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Provider"),
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.clear),
            ),
          ],
        ),
        content: FutureBuilder<List<ServiceTemplate>>(
          future: getTemplateData("assets/data.xlsx"),
          builder: (BuildContext context,
              AsyncSnapshot<List<ServiceTemplate>> snapshot) {
            Widget widget;
            if (snapshot.hasData) {
              if (selectedEntries.isEmpty) {
                selectedEntries = List.filled(snapshot.data!.length, false);
              }
              widget = Column(
                children: [
                  Table(
                      border: TableBorder.all(color: Colors.black),
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      children: [
                        const TableRow(
                            decoration: BoxDecoration(
                              color: Colors.blue,
                            ),
                            children: [
                              TableCell(child: Text("Template Name")),
                              TableCell(child: Text("Cost Components")),
                              TableCell(child: Text("Select"))
                            ]),
                        for (int i = 0; i < snapshot.data!.length; i++)
                          TableRow(
                              decoration: const BoxDecoration(
                                color: Colors.blue,
                              ),
                              children: [
                                TableCell(
                                    child:
                                        Text(snapshot.data![i].templateName)),
                                TableCell(
                                    child:
                                        Text(stringBuilder(snapshot.data![i]))),
                                Checkbox(
                                    value: selectedEntries[i],
                                    onChanged: (val) => setState(() {
                                          selectedEntries[i] = val!;
                                        }))
                              ]),
                      ]),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      ProviderSelector(
                          onSelect: (val) => setState(() {
                                selectedProvider = val;
                              })),
                      Button(
                          text: 'Add as Cost Entry',
                          onPressed: () => addCostEntires(snapshot.data!))
                    ],
                  )
                ],
              );
            } else if (snapshot.hasError) {
              widget = Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              widget = const Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Awaiting result...'),
              );
            }
            return widget;
          },
        ));
  }

  Future<List<ServiceTemplate>> getTemplateData(String path) async {
    if (templateList.isNotEmpty) return templateList;
    String templateName = "";
    List<String> templateComponentNames = [];
    List<double> templateComponentAmount = [];
    List<UnitTypes> templateComponentType = [];

    ByteData data = await rootBundle.load(path);
    var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    var excel = Excel.decodeBytes(bytes);

    var table = excel.tables["serviceTemplates"];
    for (var row in table!.rows) {
      templateName = row.elementAt(0)!.value.toString();
      templateComponentNames = [];
      templateComponentAmount = [];
      templateComponentType = [];
      for (var columnIndex = 1;
          columnIndex + 2 < row.length;
          columnIndex = columnIndex + 3) {
        if (row.elementAt(columnIndex) == null ||
            row.elementAt(columnIndex + 1) == null ||
            row.elementAt(columnIndex + 2) == null) {
          break;
        }
        Data nameCell = row.elementAt(columnIndex)!;
        Data amountCell = row.elementAt(columnIndex + 1)!;
        Data unitCell = row.elementAt(columnIndex + 2)!;

        templateComponentNames.add(nameCell.value.toString());
        templateComponentType.add(
            ProviderInformation.getUnitTypeEnum(unitCell.value.toString()));
        templateComponentAmount.add(double.parse(amountCell.value.toString()));
      }
      templateList.add(ServiceTemplate(
          templateName: templateName,
          componentNames: templateComponentNames,
          componentUnits: templateComponentType,
          componentAmounts: templateComponentAmount));
    }
    return templateList;
  }

  String stringBuilder(ServiceTemplate template) {
    String returnString = "";
    for (int i = 0; i < template.componentNames.length; i++) {
      returnString +=
          "${template.componentNames[i]}: ${template.componentAmounts[i]} ${ProviderInformation.getUnitTypeString(template.componentUnits[i])}";
      if (i != template.componentAmounts.length - 1) {
        returnString += "\n";
      }
    }
    return returnString;
  }

  void addCostEntires(List<ServiceTemplate> serviceTemplates) async {
    ProviderInformation providerInformation =
        await ref.read(providerInformationProvider.future);

    for (int templateIndex = 0;
        templateIndex < serviceTemplates.length;
        templateIndex++) {
      if (selectedEntries[templateIndex] == false) continue;

      List<double> amounts = [];
      providerComponentLoop:
      for (int providerComponentIndex = 0;
          providerComponentIndex <
              providerInformation
                  .serviceComponentNames[selectedProvider].length;
          providerComponentIndex++) {
        for (int templateComponentIndex = 0;
            templateComponentIndex <
                serviceTemplates[templateIndex].componentNames.length;
            templateComponentIndex++) {
          //Check Name and Unit is Equal
          if (providerInformation.serviceComponentNames[selectedProvider]
                      [providerComponentIndex] ==
                  serviceTemplates[templateIndex]
                      .componentNames[templateComponentIndex] &&
              providerInformation.serviceComponentUnits[selectedProvider]
                      [providerComponentIndex] ==
                  serviceTemplates[templateIndex]
                      .componentUnits[templateComponentIndex]) {
            amounts.add(serviceTemplates[templateIndex]
                .componentAmounts[templateComponentIndex]);
            continue providerComponentLoop;
          }
        }
        amounts.add(0);
      }
      ref.read(dataStorageProvider.notifier).addServiceEntry(
          selectedProvider,
          amounts,
          "${serviceTemplates[templateIndex].templateName} provided by ${providerInformation.serviceName[selectedProvider]}");
    }
  }
}
