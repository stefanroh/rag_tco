import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rag_tco/calculation/calculate_service.dart';
import 'package:rag_tco/components/button.dart';
import 'package:rag_tco/components/service/new/IO/i_o_dialog.dart';
import 'package:rag_tco/components/service/new/IO/i_o_storage.dart';
import 'package:rag_tco/components/service/new/language_model/language_model_dialog.dart';
import 'package:rag_tco/components/service/new/language_model/language_model_selector.dart';
import 'package:rag_tco/components/service/new/reranker/reranker_dialog.dart';
import 'package:rag_tco/components/service/new/reranker/reranker_selector.dart';
import 'package:rag_tco/components/service/new/retriever/retriever_dialog.dart';
import 'package:rag_tco/components/service/new/retriever/retriever_selector.dart';
import 'package:rag_tco/data_model/new/rag_component_language_model.dart';
import 'package:rag_tco/data_model/new/rag_component_reranker.dart';
import 'package:rag_tco/data_model/new/rag_component_retriever.dart';

class Services extends ConsumerStatefulWidget {
  const Services({super.key});

  @override
  ServicesState createState() => ServicesState();
}

class ServicesState extends ConsumerState<Services> {
  IOStorage ioStorage = IOStorage();
  CalculateService serviceCostCalculation = CalculateService();
  RagComponentLanguageModel? selectedLanguageModel;
  RagComponentReranker? selectedReranker;
  RagComponentRetriever? selectedRetriever;

  @override
  Widget build(BuildContext context) {
    serviceCostCalculation.ioStorage = ioStorage;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("RAG Configuration"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(children: [
                  const SizedBox(
                      width: 200, child: Text("Select Language Model")),
                  LanguageModelSelector(
                      width: 200,
                      initialSelection: selectedLanguageModel,
                      onSelected: (val) =>
                          (serviceCostCalculation.languageModel = val)),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Button(
                        text: "View Language Model",
                        onPressed: () => _langueModelDialog(context)),
                  ),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const SizedBox(width: 200, child: Text("Select Retriever")),
                    RetrieverSelector(
                        width: 200,
                        initialSelection: selectedRetriever,
                        onSelected: (val) =>
                            (serviceCostCalculation.retriever = val)),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Button(
                          text: "View Retriever",
                          onPressed: () => _retrieverDialog(context)),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const SizedBox(width: 200, child: Text("Select Reranker")),
                    RerankerSelector(
                        width: 200,
                        initialSelection: selectedReranker,
                        onSelected: (val) =>
                            (serviceCostCalculation.reranker = val)),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Button(
                          text: "View Reranker",
                          onPressed: () => _rerankerDialog(context)),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const SizedBox(
                        width: 200, child: Text("Set Input/Output Amounts")),
                    Button(
                        text: "Input / Output Amounts",
                        onPressed: () => _ioDialog(context)),
                  ],
                ),
              ),
              Button(
                  text: "Calculate Cost",
                  onPressed: () {
                    setState(() {
                      serviceCostCalculation.calculateCost();
                    });
                  }),
              Text(serviceCostCalculation.getTotalCostString()),
              Text(serviceCostCalculation.getInputCostString()),
              Text(serviceCostCalculation.getOutputCostString()),
              Text(serviceCostCalculation.getContextCostString()),
            ]),
      ],
    );
  }

  Future<void> _langueModelDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return const LanguageModelDialog();
        });
  }

  Future<void> _retrieverDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return const RetrieverDialog();
        });
  }

  Future<void> _rerankerDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return const RerankerDialog();
        });
  }

  Future<void> _ioDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return IODialog(
            storage: ioStorage,
          );
        });
  }
}
