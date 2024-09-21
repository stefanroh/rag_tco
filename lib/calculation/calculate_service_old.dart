import 'package:rag_tco/components/service/old/use_case/i_o_component.dart';
import 'package:rag_tco/components/service/old/use_case/use_case_storage.dart';
import 'package:rag_tco/data_model/old/rag_component_language_model.dart';
import 'package:rag_tco/data_model/old/rag_component_preprocessor.dart';
import 'package:rag_tco/data_model/old/rag_component_reranker.dart';
import 'package:rag_tco/data_model/old/rag_component_retriever.dart';
import 'package:rag_tco/data_model/old/rag_component_storage.dart';
import 'package:rag_tco/data_model/old/rag_component_vectordb.dart';
import 'package:rag_tco/misc/language_model_price_component_types.dart';

class CalculateServiceOld {
  CalculateServiceOld(
      {this.languageModel, this.reranker, this.retriever, this.useCaseStorage});

  RagComponentLanguageModel? languageModel;
  RagComponentReranker? reranker;
  RagComponentRetriever? retriever;
  RagComponentStorage? storage;
  RagComponentVectordb? vectorDB;
  RagComponentPreprocessor? preprocessor;
  UseCaseStorage? useCaseStorage;

  double inputSingleCost = 0;
  double outputSingleCost = 0;
  double contextSingleCost = 0;

  double storageCost = 0;
  double vectorDBCost = 0;
  double preprocessorCost = 0;

  double singleVariableCost = 0;
  double totalVariableCost = 0;
  double totalFixCost = 0;

  double useCaseCost = 0;

  double calculateCost() {
    double calcInputCost = 0;
    double calcOutputCost = 0;
    double calcContextCost = 0;
    double calcStorageCost = 0;
    double calcVectorDBCost = 0;
    double calcPreprocessorCost = 0;

    if (useCaseStorage == null) {
      inputSingleCost = 0;
      outputSingleCost = 0;
      contextSingleCost = 0;
      storageCost = 0;
      vectorDBCost = 0;
      preprocessorCost = 0;
      singleVariableCost = 0;
      totalVariableCost = 0;
      totalFixCost = 0;
      useCaseCost = 0;
      return 0;
    }

    //If LLM is set
    if (languageModel != null) {
      //LLM Input
      for (IOComponent component in useCaseStorage!.inputComponents) {
        calcInputCost += languageModel!
            .calculateCost(true, component.type, component.amount);
      }

      //LLM Output
      for (IOComponent component in useCaseStorage!.outputComponents) {
        calcOutputCost += languageModel!
            .calculateCost(false, component.type, component.amount);
      }

      //If Retriever is set, calc context cost
      if (retriever != null) {
        //If Reranker is set, calc context cost with reranker
        if (reranker != null) {
          int contextToken = reranker!.getRerankedTokens(
              retriever!.retrievedDocuments, retriever!.chunkSize);

          calcContextCost = languageModel!.calculateCost(
              true, LanguageModelPriceComponentTypes.text, contextToken);
        }
        //If Reranker is not set, calc context cost only with retriever
        else {
          int contextToken =
              retriever!.retrievedDocuments * retriever!.chunkSize;

          calcContextCost = languageModel!.calculateCost(
              true, LanguageModelPriceComponentTypes.text, contextToken);
        }
      }
    }

    //Storage
    if (storage != null) {
      calcStorageCost = useCaseStorage!.storageAmount * storage!.costPerGB;
    }

    //VectorDB
    if (vectorDB != null) {
      calcVectorDBCost =
          useCaseStorage!.vectorDBUpdate * vectorDB!.costPerUpdate;
    }

    //Preprocessor
    if (preprocessor != null) {
      calcPreprocessorCost = useCaseStorage!.preprocessorOperation *
          preprocessor!.costPerOperation;
    }

    //Save Calculation
    inputSingleCost = calcInputCost;
    outputSingleCost = calcOutputCost;
    contextSingleCost = calcContextCost;
    storageCost = calcStorageCost;
    vectorDBCost = calcVectorDBCost;
    preprocessorCost = calcPreprocessorCost;

    //Total and Fix
    totalFixCost = calcStorageCost + calcVectorDBCost + calcPreprocessorCost;
    singleVariableCost = calcInputCost + calcOutputCost + calcContextCost;
    totalVariableCost = singleVariableCost * useCaseStorage!.frequency;

    //Use Case
    useCaseCost = totalVariableCost + totalFixCost;
    return useCaseCost;
  }

  String getInputCostString() {
    return "Input Cost: ${inputSingleCost.toString()}";
  }

  String getOutputCostString() {
    return "Output Cost: ${outputSingleCost.toString()}";
  }

  String getContextCostString() {
    return "Context Cost: ${contextSingleCost.toString()}";
  }

  String getStorageCostString() {
    return "Storage Cost: ${storageCost.toString()}";
  }

  String getVectorDBCostString() {
    return "Vector DB Cost: ${vectorDBCost.toString()}";
  }

  String getPreprocessorCostString() {
    return "Preprocessor Cost: ${preprocessorCost.toString()}";
  }

  String getSingleVariableCostString() {
    return "Variable Cost per Call: ${singleVariableCost.toString()}";
  }

  String getTotalVariableCostString() {
    return "Total Variable Cost: ${totalVariableCost.toString()}";
  }

  String getTotalFixCostString() {
    return "Total Fix Cost: ${totalFixCost.toString()}";
  }

  String getUseCaseCostString() {
    return "Use Case Cost: ${useCaseCost.toString()}";
  }
}
