import 'package:rag_tco/components/service/new/IO/i_o_component.dart';
import 'package:rag_tco/components/service/new/IO/i_o_storage.dart';
import 'package:rag_tco/data_model/new/rag_component_language_model.dart';
import 'package:rag_tco/data_model/new/rag_component_reranker.dart';
import 'package:rag_tco/data_model/new/rag_component_retriever.dart';
import 'package:rag_tco/misc/language_model_price_component_types.dart';

class CalculateService {
  CalculateService(
      {this.languageModel, this.reranker, this.retriever, this.ioStorage});

  RagComponentLanguageModel? languageModel;
  RagComponentReranker? reranker;
  RagComponentRetriever? retriever;
  IOStorage? ioStorage;

  double inputCost = 0;
  double outputCost = 0;
  double contextCost = 0;

  double calculateCost() {
    double calcInputCost = 0;
    double calcOutputCost = 0;
    double calcContextCost = 0;

    if (languageModel == null ||
        reranker == null ||
        retriever == null ||
        ioStorage == null) {
      return 0;
    }

    for (IOComponent component in ioStorage!.inputComponents) {
      calcInputCost +=
          languageModel!.calculateCost(true, component.type, component.amount);
    }

    for (IOComponent component in ioStorage!.outputComponents) {
      calcOutputCost +=
          languageModel!.calculateCost(false, component.type, component.amount);
    }

    double contextToken =
        retriever!.getRetrievedTokens() * reranker!.compactionRate;
    calcContextCost = languageModel!.calculateCost(
        true, LanguageModelPriceComponentTypes.text, contextToken);

    inputCost = calcInputCost;
    outputCost = calcOutputCost;
    contextCost = calcContextCost;
    return calcInputCost + calcOutputCost + calcContextCost;
  }

  String getInputCostString() {
    return "Input Cost: ${inputCost.toString()}";
  }

  String getOutputCostString() {
    return "Output Cost: ${outputCost.toString()}";
  }

  String getContextCostString() {
    return "Context Cost: ${contextCost.toString()}";
  }

  String getTotalCostString() {
    return "Total Cost ${(inputCost + outputCost + contextCost).toString()}";
  }
}
