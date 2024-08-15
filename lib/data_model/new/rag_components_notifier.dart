import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rag_tco/data_model/new/price_component.dart';
import 'package:rag_tco/data_model/new/rag_component_language_model.dart';
import 'package:rag_tco/data_model/new/rag_component_reranker.dart';
import 'package:rag_tco/data_model/new/rag_component_retriever.dart';
import 'package:rag_tco/data_model/new/rag_components.dart';

class RagComponentsNotifier extends AsyncNotifier<RagComponents> {
  @override
  FutureOr<RagComponents> build() {
    return RagComponents.fromExcel("assets/data.xlsx");
  }

  List<RagComponentLanguageModel> getLanguageModels() {
    if (state.value == null) return [];
    return state.value!.lanugageModels;
  }

  void addLanguageModel(String name) {
    List<RagComponentLanguageModel> languageModels =
        List<RagComponentLanguageModel>.from(state.value!.lanugageModels);
    languageModels.add(RagComponentLanguageModel(name: name));
    state = AsyncValue.data(
        state.value!.copyWith(newLanguageModels: languageModels));
  }

  void removeLanguageModel(RagComponentLanguageModel model) {
    List<RagComponentLanguageModel> languageModels =
        List<RagComponentLanguageModel>.from(state.value!.lanugageModels);
    languageModels.removeWhere((element) => element == model);
    state = AsyncValue.data(
        state.value!.copyWith(newLanguageModels: languageModels));
  }

  void removeLanguageModelComponent(
      RagComponentLanguageModel model, PriceComponent component) {
    List<RagComponentLanguageModel> languageModels =
        List<RagComponentLanguageModel>.from(state.value!.lanugageModels);
    model.removeComponent(component);
    state = AsyncValue.data(
        state.value!.copyWith(newLanguageModels: languageModels));
  }

  void addLanguageModelComponent(
      RagComponentLanguageModel model, PriceComponent component) {
    List<RagComponentLanguageModel> languageModels =
        List<RagComponentLanguageModel>.from(state.value!.lanugageModels);
    model.addPriceComponentByObject(component);
    state = AsyncValue.data(
        state.value!.copyWith(newLanguageModels: languageModels));
  }

  void addReranker(RagComponentReranker newReranker) {
    List<RagComponentReranker> rerankerList =
        List<RagComponentReranker>.from(state.value!.reranker);
    rerankerList.add(newReranker);
    state = AsyncValue.data(state.value!.copyWith(newReranker: rerankerList));
  }

  void updateReranker(RagComponentReranker reranker,
      {String? newName,
      double? newCompactionRate,
      int? newRerankedDocuments,
      bool? newUseCompactionModel}) {
    List<RagComponentReranker> rerankerList =
        List<RagComponentReranker>.from(state.value!.reranker);
    reranker.name = newName ?? reranker.name;
    reranker.compactionRate = newCompactionRate ?? reranker.compactionRate;
    reranker.rerankedDocuments =
        newRerankedDocuments ?? reranker.rerankedDocuments;
    reranker.useCompactionModel =
        newUseCompactionModel ?? reranker.useCompactionModel;
    state = AsyncValue.data(state.value!.copyWith(newReranker: rerankerList));
  }

  void removeReranker(RagComponentReranker reranker) {
    List<RagComponentReranker> rerankerList =
        List<RagComponentReranker>.from(state.value!.reranker);

    rerankerList.removeWhere((element) => element == reranker);
    state = AsyncValue.data(state.value!.copyWith(newReranker: rerankerList));
  }

  void addRetriever(RagComponentRetriever retriever) {
    List<RagComponentRetriever> retrieverList =
        List<RagComponentRetriever>.from(state.value!.retriever);
    retrieverList.add(retriever);
    state = AsyncValue.data(state.value!.copyWith(newRetriever: retrieverList));
  }

  void updateRetriever(RagComponentRetriever retriever,
      {String? newName, int? newRetrievedDocuments, int? newChunkSize}) {
    List<RagComponentRetriever> retrieverList =
        List<RagComponentRetriever>.from(state.value!.retriever);
    retriever.name = newName ?? retriever.name;
    retriever.retrievedDocuments =
        newRetrievedDocuments ?? retriever.retrievedDocuments;
    retriever.chunkSize = newChunkSize ?? retriever.chunkSize;
    state = AsyncValue.data(state.value!.copyWith(newRetriever: retrieverList));
  }

  void removeRetriever(RagComponentRetriever retriever) {
    List<RagComponentRetriever> retrieverList =
        List<RagComponentRetriever>.from(state.value!.retriever);
    retrieverList.removeWhere((element) => element == retriever);
    state = AsyncValue.data(state.value!.copyWith(newRetriever: retrieverList));
  }
}
