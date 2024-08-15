import 'package:excel/excel.dart';
import 'package:flutter/services.dart';
import 'package:rag_tco/data_model/new/rag_component_language_model.dart';
import 'package:rag_tco/data_model/new/rag_component_reranker.dart';
import 'package:rag_tco/data_model/new/rag_component_retriever.dart';
import 'package:rag_tco/misc/language_model_price_component_types.dart';

class RagComponents {
  RagComponents(
      {this.lanugageModels = const [],
      this.reranker = const [],
      this.retriever = const []});

  List<RagComponentLanguageModel> lanugageModels;
  List<RagComponentReranker> reranker;
  List<RagComponentRetriever> retriever;

  static Future<RagComponents> fromExcel(String path) async {
    List<RagComponentLanguageModel> loadedLanguageModels = [];

    ByteData data = await rootBundle.load(path);
    var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    var excel = Excel.decodeBytes(bytes);

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
    return RagComponents(lanugageModels: loadedLanguageModels);
  }

  RagComponents copyWith(
      {List<RagComponentLanguageModel>? newLanguageModels,
      List<RagComponentReranker>? newReranker,
      List<RagComponentRetriever>? newRetriever}) {
    return RagComponents(
        lanugageModels: newLanguageModels ?? lanugageModels,
        reranker: newReranker ?? reranker,
        retriever: newRetriever ?? retriever);
  }

  // static UnitTypes _getUnitTypeEnum(String unitString) {
  //   String formattedUnitString = _formatDataType(unitString);
  //   switch (formattedUnitString) {
  //     case "token":
  //       return UnitTypes.token;
  //     case "picture":
  //       return UnitTypes.picture;
  //     case "character":
  //       return UnitTypes.character;
  //     case "second":
  //       return UnitTypes.second;
  //     case "minute":
  //     default:
  //       return UnitTypes.unknown;
  //   }
  // }

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
