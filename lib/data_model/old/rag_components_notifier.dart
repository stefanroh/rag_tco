import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rag_tco/data_model/old/price_component.dart';
import 'package:rag_tco/data_model/old/rag_component_language_model.dart';
import 'package:rag_tco/data_model/old/rag_component_preprocessor.dart';
import 'package:rag_tco/data_model/old/rag_component_reranker.dart';
import 'package:rag_tco/data_model/old/rag_component_retriever.dart';
import 'package:rag_tco/data_model/old/rag_component_storage.dart';
import 'package:rag_tco/data_model/old/rag_component_vectordb.dart';
import 'package:rag_tco/data_model/old/rag_components.dart';

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
      double? newcompressionRate,
      int? newRerankedDocuments,
      bool? newUsecompressionModel}) {
    List<RagComponentReranker> rerankerList =
        List<RagComponentReranker>.from(state.value!.reranker);
    reranker.name = newName ?? reranker.name;
    reranker.compressionRate = newcompressionRate ?? reranker.compressionRate;
    reranker.rerankedDocuments =
        newRerankedDocuments ?? reranker.rerankedDocuments;
    reranker.usecompressionModel =
        newUsecompressionModel ?? reranker.usecompressionModel;
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

  void addStorage(RagComponentStorage storage){
    List<RagComponentStorage> storagesList =
        List<RagComponentStorage>.from(state.value!.storages);
    storagesList.add(storage);
    state = AsyncValue.data(state.value!.copyWith(newStorages: storagesList));
  }

  void updateStorage(RagComponentStorage storage,
      {String? newName, double? newCostPerGB}) {
    List<RagComponentStorage> storagesList =
        List<RagComponentStorage>.from(state.value!.storages);
    storage.name = newName ?? storage.name;
    storage.costPerGB =
        newCostPerGB ?? storage.costPerGB;
    state = AsyncValue.data(state.value!.copyWith(newStorages: storagesList));
  }

  void removeStorage(RagComponentStorage storage) {
    List<RagComponentStorage> storagesList =
        List<RagComponentStorage>.from(state.value!.storages);
    storagesList.removeWhere((element) => element == storage);
    state = AsyncValue.data(state.value!.copyWith(newStorages: storagesList));
  }

  void addVectorDB(RagComponentVectordb vectorDB){
    List<RagComponentVectordb> vectorDBList =
        List<RagComponentVectordb>.from(state.value!.vectorDBs);
    vectorDBList.add(vectorDB);
    state = AsyncValue.data(state.value!.copyWith(newVectorDBs: vectorDBList));
  }

  void updateVectorDB(RagComponentVectordb vectorDB,
      {String? newName, double? newCostPerUpdate}) {
    List<RagComponentVectordb> vectorDBList =
        List<RagComponentVectordb>.from(state.value!.vectorDBs);
    vectorDB.name = newName ?? vectorDB.name;
    vectorDB.costPerUpdate =
        newCostPerUpdate ?? vectorDB.costPerUpdate;
    state = AsyncValue.data(state.value!.copyWith(newVectorDBs: vectorDBList));
  }

  void removeVectorDB(RagComponentVectordb vectorDB) {
    List<RagComponentVectordb> vectorDBList =
        List<RagComponentVectordb>.from(state.value!.vectorDBs);
    vectorDBList.removeWhere((element) => element == vectorDB);
    state = AsyncValue.data(state.value!.copyWith(newVectorDBs: vectorDBList));
  }

  void addPreprocessor(RagComponentPreprocessor preprocessor){
    List<RagComponentPreprocessor> preprocessorList =
        List<RagComponentPreprocessor>.from(state.value!.preprocessors);
    preprocessorList.add(preprocessor);
    state = AsyncValue.data(state.value!.copyWith(newPreprocessors: preprocessorList));
  }

  void updatePreprocessor(RagComponentPreprocessor preprocessor,
      {String? newName, double? newCostPerOperation}) {
    List<RagComponentPreprocessor> preprocessorList =
        List<RagComponentPreprocessor>.from(state.value!.preprocessors);
    preprocessor.name = newName ?? preprocessor.name;
    preprocessor.costPerOperation =
        newCostPerOperation ?? preprocessor.costPerOperation;
    state = AsyncValue.data(state.value!.copyWith(newPreprocessors: preprocessorList));
  }

  void removePreprocessor(RagComponentPreprocessor preprocessor) {
    List<RagComponentPreprocessor> preprocessorList =
        List<RagComponentPreprocessor>.from(state.value!.preprocessors);
    preprocessorList.removeWhere((element) => element == preprocessor);
    state = AsyncValue.data(state.value!.copyWith(newPreprocessors: preprocessorList));
  }
}
