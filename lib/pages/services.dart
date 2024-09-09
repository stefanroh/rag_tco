import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rag_tco/calculation/calculate_service.dart';
import 'package:rag_tco/components/button.dart';
import 'package:rag_tco/components/service/new/architecture_component/architecture_dialog.dart';
import 'package:rag_tco/components/service/old/preprocessor/preprocessor_dialog.dart';
import 'package:rag_tco/components/service/old/preprocessor/preprocessor_selector.dart';
import 'package:rag_tco/components/service/old/storage/storage_dialog.dart';
import 'package:rag_tco/components/service/old/storage/storage_selector.dart';
import 'package:rag_tco/components/service/new/use_case/use_case_dialog.dart';
import 'package:rag_tco/components/service/new/use_case/use_case_storage.dart';
import 'package:rag_tco/components/service/old/language_model/language_model_dialog.dart';
import 'package:rag_tco/components/service/old/language_model/language_model_selector.dart';
import 'package:rag_tco/components/service/old/reranker/reranker_dialog.dart';
import 'package:rag_tco/components/service/old/reranker/reranker_selector.dart';
import 'package:rag_tco/components/service/old/retriever/retriever_dialog.dart';
import 'package:rag_tco/components/service/old/retriever/retriever_selector.dart';
import 'package:rag_tco/components/service/old/vectorDB/vectordb_dialog.dart';
import 'package:rag_tco/components/service/old/vectorDB/vectordb_selector.dart';
import 'package:rag_tco/data_model/old/rag_component_language_model.dart';
import 'package:rag_tco/data_model/old/rag_component_preprocessor.dart';
import 'package:rag_tco/data_model/old/rag_component_reranker.dart';
import 'package:rag_tco/data_model/old/rag_component_retriever.dart';
import 'package:rag_tco/data_model/old/rag_component_storage.dart';
import 'package:rag_tco/data_model/old/rag_component_vectordb.dart';

class Services extends ConsumerStatefulWidget {
  const Services({super.key});

  @override
  ServicesState createState() => ServicesState();
}

class ServicesState extends ConsumerState<Services> {
  UseCaseStorage useCaseStorage = UseCaseStorage();
  CalculateService serviceCostCalculation = CalculateService();
  RagComponentLanguageModel? selectedLanguageModel;
  RagComponentReranker? selectedReranker;
  RagComponentRetriever? selectedRetriever;
  RagComponentStorage? selectedStorage;
  RagComponentVectordb? selectedVectorDB;
  RagComponentPreprocessor? selectedPreprocessor;

  TextEditingController frequencyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    serviceCostCalculation.useCaseStorage = useCaseStorage;
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
                    const SizedBox(width: 200, child: Text("Select Storage")),
                    StorageSelector(
                        width: 200,
                        initialSelection: selectedStorage,
                        onSelected: (val) =>
                            (serviceCostCalculation.storage = val)),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Button(
                          text: "View Storage",
                          onPressed: () => _storageDialog(context)),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const SizedBox(width: 200, child: Text("Select Vector DB")),
                    VectordbSelector(
                        width: 200,
                        initialSelection: selectedVectorDB,
                        onSelected: (val) =>
                            (serviceCostCalculation.vectorDB = val)),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Button(
                          text: "View Vector DBs",
                          onPressed: () => _vectorDBDialog(context)),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const SizedBox(
                        width: 200, child: Text("Select Preprocessor")),
                    PreprocessorSelector(
                        width: 200,
                        initialSelection: selectedPreprocessor,
                        onSelected: (val) =>
                            (serviceCostCalculation.preprocessor = val)),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Button(
                          text: "View Preprocessors",
                          onPressed: () => _preprocessorDialog(context)),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const SizedBox(
                        width: 200, child: Text("Set Use Case Settings")),
                    Button(
                        text: "Settings",
                        onPressed: () => _useCaseDialog(context)),
                  ],
                ),
              ),
              Button(
                text: "Architecture Components",
                onPressed: () => _architectureComponentDialog(context),
              ),
              Button(
                  text: "Calculate Cost",
                  onPressed: () {
                    serviceCostCalculation.calculateCost();
                    setState(() {});
                  }),
              Text(serviceCostCalculation.getInputCostString()),
              Text(serviceCostCalculation.getOutputCostString()),
              Text(serviceCostCalculation.getContextCostString()),
              const SizedBox(
                height: 10,
              ),
              Text(serviceCostCalculation.getSingleVariableCostString()),
              Text(serviceCostCalculation.getTotalVariableCostString()),
              Text(serviceCostCalculation.getTotalFixCostString()),
              const SizedBox(
                height: 10,
              ),
              Text(serviceCostCalculation.getUseCaseCostString())
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

  Future<void> _storageDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return const StorageDialog();
        });
  }

  Future<void> _vectorDBDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return const VectordbDialog();
        });
  }

  Future<void> _preprocessorDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return const PreprocessorDialog();
        });
  }

  Future<void> _useCaseDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return UseCaseDialog(
            storage: useCaseStorage,
          );
        });
  }

  Future<void> _architectureComponentDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return const ArchitectureDialog();
        });
  }
}
