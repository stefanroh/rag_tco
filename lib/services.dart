import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rag_tco/calculation/calculate_service.dart';
import 'package:rag_tco/components/button.dart';
import 'package:rag_tco/components/architecture_component/architecture_dialog.dart';
import 'package:rag_tco/components/use_case/use_case_components.dart';
import 'package:rag_tco/components/variable_dialog.dart';
import 'package:rag_tco/data_model/architecture_components_storage.dart';
import 'package:rag_tco/data_model/use_case_storage.dart';
import 'package:rag_tco/misc/copyright_dialog.dart';
import 'package:rag_tco/misc/provider.dart';

class Services extends ConsumerStatefulWidget {
  const Services({super.key});

  @override
  ServicesState createState() => ServicesState();
}

class ServicesState extends ConsumerState<Services> {
  UseCaseStorage useCaseStorage = UseCaseStorage();

  TextEditingController frequencyController = TextEditingController();

  Map<String, dynamic> variables = <String, dynamic>{};
  late CalculateService calculation;

  @override
  void initState() {
    super.initState();
    fillVariables();
    calculation = CalculateService(useCaseStorage, variables);
  }

  @override
  Widget build(BuildContext context) {
    AsyncValue<ArchitectureComponentsStorage> asyncComponentStorage =
        ref.watch(architectureComponentProvider);

    switch (asyncComponentStorage) {
      case AsyncData(:final value):
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () => _copyrightDialog(context),
                  icon: const Icon(Icons.info),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 25,
                      ),
                      const Text(
                        "RAG Configuration",
                        style: TextStyle(fontSize: 24),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          children: [
                            const SizedBox(
                                width: 150, child: Text("Set Variables")),
                            Button(
                                text: "Variables",
                                onPressed: () =>
                                    _variableDialog(context, variables)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          children: [
                            const SizedBox(
                                width: 150, child: Text("View Components")),
                            Button(
                              text: "Architecture Components",
                              onPressed: () =>
                                  _architectureComponentDialog(context),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          children: [
                            const SizedBox(
                                width: 150, child: Text("Calcuation")),
                            Button(
                                text: "Calculate Cost",
                                onPressed: () {
                                  calculation.calculateCost();
                                  // serviceCostCalculation.calculateCost();
                                  setState(() {});
                                }),
                          ],
                        ),
                      ),
                    ]),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    const Text(
                      "Architecture Setup",
                      style: TextStyle(fontSize: 24),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    UseCaseComponents(
                        storage: useCaseStorage,
                        components: value.componentList),
                  ],
                )
              ],
            ),
            const Divider(),
            Row(
              children: [
                SizedBox(
                  width: 750,
                  height: 500,
                  child: SingleChildScrollView(
                    child: calculation.getCostTable(),
                  ),
                ),
                calculation.getCostChart()
              ],
            )
          ],
        );
      case AsyncError(:final error):
        return Text("$error");
      default:
        return const Text("Loading");
    }
  }

  Future<void> _architectureComponentDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return const ArchitectureDialog();
        });
  }

  Future<void> _copyrightDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return const CopyrightDialog();
        });
  }

  Future<void> _variableDialog(
      BuildContext context, Map<String, dynamic> variableStorage) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return VariableDialog(
            context,
            variableStorage: variableStorage,
          );
        });
  }

  void fillVariables() {
    variables["tokenPerCharacter"] = "0.25";
    variables["docSize"] = "0.001"; //GB
    variables["docLength"] = "10000"; //3000 per Page, Around 3.3 Pages each
    variables["casesPerCustomer"] = "0.05";
    variables["queriesPerCase"] = "2.5";
    variables["queriesPerEmployee"] = "5";

    variables["#employees"] = "5000";
    variables["#customers"] = "100000";
    variables["#internalDoc"] = "300000";
    variables["#productDoc"] = "1250";
    variables["promptLength"] = "100";
    variables["outputLength"] = "500";
    variables["retrievedChunks"] = "10";
    variables["chunkSize"] = "1600";
  }
}
