import 'dart:developer';

import 'package:excel/excel.dart';
import 'package:flutter/services.dart';
import 'package:rag_tco/data_model/new/rag_component_language_model.dart';
import 'package:rag_tco/data_model/new/rag_component_preprocessor.dart';
import 'package:rag_tco/data_model/new/rag_component_reranker.dart';
import 'package:rag_tco/data_model/new/rag_component_retriever.dart';
import 'package:rag_tco/data_model/new/rag_component_storage.dart';
import 'package:rag_tco/data_model/new/rag_component_vectordb.dart';
import 'package:rag_tco/misc/language_model_price_component_types.dart';

class RagComponents {
  RagComponents(
      {this.lanugageModels = const [],
      this.reranker = const [],
      this.retriever = const [],
      this.storages = const [],
      this.vectorDBs = const [],
      this.preprocessors = const []});

  List<RagComponentLanguageModel> lanugageModels;
  List<RagComponentReranker> reranker;
  List<RagComponentRetriever> retriever;
  List<RagComponentStorage> storages;
  List<RagComponentVectordb> vectorDBs;
  List<RagComponentPreprocessor> preprocessors;

  static Future<RagComponents> fromExcel(String path) async {
    List<RagComponentLanguageModel> loadedLanguageModels = [];
    List<RagComponentReranker> loadedReranker = [];
    List<RagComponentRetriever> loadedRetriever = [];
    List<RagComponentStorage> loadedStorages = [];
    List<RagComponentVectordb> loadedVectorDBs = [];
    List<RagComponentPreprocessor> loadedPreprocessors = [];

    ByteData data = await rootBundle.load(path);
    var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    var excel = Excel.decodeBytes(bytes);

    //Load Language Models
    var table = excel.tables["languageModel"];
    for (var row in table!.rows) {
      RagComponentLanguageModel languageModel =
          RagComponentLanguageModel(name: row.elementAt(0)!.value.toString());
      for (var columnIndex = 1;
          columnIndex + 3 < row.length;
          columnIndex = columnIndex + 4) {
        if (row.elementAt(columnIndex) == null ||
            row.elementAt(columnIndex + 1) == null ||
            row.elementAt(columnIndex + 2) == null ||
            row.elementAt(columnIndex + 3) == null) {
          break;
        }
        Data inputCell = row.elementAt(columnIndex)!;
        Data typeCell = row.elementAt(columnIndex + 1)!;
        Data priceCell = row.elementAt(columnIndex + 2)!;
        Data amountCell = row.elementAt(columnIndex + 3)!;

        languageModel.addPriceComponentByValue(
            (inputCell.value.toString().toLowerCase() == "input"),
            _getPriceComponentType(typeCell.value.toString()),
            double.parse(priceCell.value.toString()),
            double.parse(amountCell.value.toString()));
      }
      loadedLanguageModels.add(languageModel);
    }

    //Load Reranker
    table = excel.tables["reranker"];
    for (var row in table!.rows) {
      if (row.elementAt(0) == null ||
          row.elementAt(1) == null ||
          row.elementAt(2) == null) {
        break;
      }

      Data nameCell = row.elementAt(0)!;
      Data typeCell = row.elementAt(1)!;
      Data configCell = row.elementAt(2)!;

      bool useCompression =
          typeCell.value.toString().toLowerCase() == "compression";

      RagComponentReranker reranker = RagComponentReranker(
          name: nameCell.value.toString(),
          compressionRate:
              useCompression ? double.parse(configCell.value.toString()) : 1,
          usecompressionModel: useCompression,
          rerankedDocuments:
              !useCompression ? int.parse(configCell.value.toString()) : 0);

      loadedReranker.add(reranker);
    }

    //Load Retriever
    table = excel.tables["retriever"];
    for (var row in table!.rows) {
      if (row.elementAt(0) == null ||
          row.elementAt(1) == null ||
          row.elementAt(2) == null) {
        break;
      }

      Data nameCell = row.elementAt(0)!;
      Data docCell = row.elementAt(1)!;
      Data chunkCell = row.elementAt(2)!;

      RagComponentRetriever retriever = RagComponentRetriever(
          name: nameCell.value.toString(),
          retrievedDocuments: int.parse(docCell.value.toString()),
          chunkSize: int.parse(chunkCell.value.toString()));

      loadedRetriever.add(retriever);
    }

    //Load Storages
    table = excel.tables["storage"];
    for (var row in table!.rows) {
      if (row.elementAt(0) == null || row.elementAt(1) == null) {
        break;
      }

      Data nameCell = row.elementAt(0)!;
      Data costCell = row.elementAt(1)!;

      RagComponentStorage storage = RagComponentStorage(
          name: nameCell.value.toString(),
          costPerGB: double.parse(costCell.value.toString()));

      loadedStorages.add(storage);
    }

    //Load VectorDBs
    table = excel.tables["vectorDB"];
    for (var row in table!.rows) {
      if (row.elementAt(0) == null || row.elementAt(1) == null) {
        break;
      }

      Data nameCell = row.elementAt(0)!;
      Data costCell = row.elementAt(1)!;

      RagComponentVectordb vectorDB = RagComponentVectordb(
          name: nameCell.value.toString(),
          costPerUpdate: double.parse(costCell.value.toString()));

      loadedVectorDBs.add(vectorDB);
    }

    //Load Preprocessors
    table = excel.tables["preprocessor"];
    for (var row in table!.rows) {
      if (row.elementAt(0) == null || row.elementAt(1) == null) {
        break;
      }

      Data nameCell = row.elementAt(0)!;
      Data costCell = row.elementAt(1)!;

      RagComponentPreprocessor preprocessors = RagComponentPreprocessor(
          name: nameCell.value.toString(),
          costPerOperation: double.parse(costCell.value.toString()));

      loadedPreprocessors.add(preprocessors);
    }

    return RagComponents(
        lanugageModels: loadedLanguageModels,
        reranker: loadedReranker,
        retriever: loadedRetriever,
        storages: loadedStorages,
        vectorDBs: loadedVectorDBs,
        preprocessors: loadedPreprocessors);
  }

  RagComponents copyWith(
      {List<RagComponentLanguageModel>? newLanguageModels,
      List<RagComponentReranker>? newReranker,
      List<RagComponentRetriever>? newRetriever,
      List<RagComponentStorage>? newStorages,
      List<RagComponentVectordb>? newVectorDBs,
      List<RagComponentPreprocessor>? newPreprocessors}) {
    return RagComponents(
        lanugageModels: newLanguageModels ?? lanugageModels,
        reranker: newReranker ?? reranker,
        retriever: newRetriever ?? retriever,
        storages: newStorages ?? storages,
        vectorDBs: newVectorDBs ?? vectorDBs,
        preprocessors: newPreprocessors ?? preprocessors);
  }

  static LanguageModelPriceComponentTypes _getPriceComponentType(
      String typeString) {
    String formattedString = typeString.toLowerCase();
    switch (formattedString) {
      case "text":
        return LanguageModelPriceComponentTypes.text;
      case "video":
        return LanguageModelPriceComponentTypes.video;
      case "audio":
        return LanguageModelPriceComponentTypes.audio;
      case "picture":
        return LanguageModelPriceComponentTypes.picture;
      default:
        return LanguageModelPriceComponentTypes.unknown;
    }
  }

  static String _formatDataType(String untrimmed) {
    String returnString;
    returnString = untrimmed.toLowerCase();
    if (returnString.endsWith("s")) {
      returnString = returnString.substring(0, returnString.length - 1);
    }
    return returnString;
  }
}
