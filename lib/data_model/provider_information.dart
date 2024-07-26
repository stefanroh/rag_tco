import 'package:excel/excel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:rag_tco/data_model/unit_types.dart';

@immutable
class ProviderInformation {
  static Future<ProviderInformation> fromExcel(String path) async {
    List<String> serviceName = [];
    List<List<String>> serviceComponentNames = [[]];
    List<List<double>> serviceComponentPrices = [[]];
    List<List<UnitTypes>> serviceComponentUnits = [[]];
    List<List<int>> serviceComponentAmounts = [[]];

    ByteData data = await rootBundle.load(path);
    var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    var excel = Excel.decodeBytes(bytes);

    var table = excel.tables["provider"];
    int rowIndex = 0;
    for (var row in table!.rows) {
      serviceName.add(row.elementAt(0)!.value.toString());
      serviceComponentNames.add([]);
      serviceComponentPrices.add([]);
      serviceComponentUnits.add([]);
      serviceComponentAmounts.add([]);
      for (var columnIndex = 1;
          columnIndex + 3 < row.length;
          columnIndex = columnIndex + 4) {
        if (row.elementAt(columnIndex) == null ||
            row.elementAt(columnIndex + 1) == null ||
            row.elementAt(columnIndex + 2) == null ||
            row.elementAt(columnIndex + 3) == null) {
          break;
        }
        Data nameCell = row.elementAt(columnIndex)!;
        Data priceCell = row.elementAt(columnIndex + 1)!;
        Data amountCell = row.elementAt(columnIndex + 2)!;
        Data unitCell = row.elementAt(columnIndex + 3)!;

        serviceComponentNames[rowIndex].add(nameCell.value.toString());
        serviceComponentPrices[rowIndex]
            .add(double.parse(priceCell.value.toString()));
        serviceComponentUnits[rowIndex]
            .add(getUnitTypeEnum(unitCell.value.toString()));
        serviceComponentAmounts[rowIndex]
            .add(int.parse(amountCell.value.toString()));
      }
      rowIndex++;
    }

    return ProviderInformation.fromValue(
        serviceName: serviceName,
        serviceComponentNames: serviceComponentNames,
        serviceComponentPrices: serviceComponentPrices,
        serviceComponentUnits: serviceComponentUnits,
        serviceComponentAmounts: serviceComponentAmounts);
  }

  // ignore: prefer_const_constructors_in_immutables
  ProviderInformation.fromValue(
      {required this.serviceName,
      required this.serviceComponentNames,
      required this.serviceComponentPrices,
      required this.serviceComponentUnits,
      required this.serviceComponentAmounts});

  late final List<String> serviceName;
  late final List<List<String>> serviceComponentNames;
  late final List<List<double>> serviceComponentPrices;
  late final List<List<UnitTypes>> serviceComponentUnits;
  late final List<List<int>> serviceComponentAmounts;

  ProviderInformation copyWith(
      {List<String>? newNames,
      List<List<String>>? newComponentNames,
      List<List<double>>? newComponentPrices,
      List<List<UnitTypes>>? newComponentUnits,
      List<List<int>>? newComponentAmounts}) {
    return ProviderInformation.fromValue(
        serviceName: newNames ?? serviceName,
        serviceComponentNames: newComponentNames ?? serviceComponentNames,
        serviceComponentPrices: newComponentPrices ?? serviceComponentPrices,
        serviceComponentUnits: newComponentUnits ?? serviceComponentUnits,
        serviceComponentAmounts:
            newComponentAmounts ?? serviceComponentAmounts);
  }

  static UnitTypes getUnitTypeEnum(String unitString) {
    String formattedUnitString = formatDataType(unitString);
    switch (formattedUnitString) {
      case "token":
        return UnitTypes.token;
      case "picture":
        return UnitTypes.picture;
      case "character":
        return UnitTypes.character;
      case "second":
        return UnitTypes.second;
      case "minute":
        return UnitTypes.minute;
      case "hour":
        return UnitTypes.hour;
      case "day":
        return UnitTypes.day;
      case "month":
        return UnitTypes.month;
      case "year":
        return UnitTypes.year;
      default:
        return UnitTypes.unknown;
    }
  }

  static String formatDataType(String untrimmed) {
    String returnString;
    returnString = untrimmed.toLowerCase();
    if (returnString.endsWith("s")) {
      returnString = returnString.substring(0, returnString.length - 1);
    }
    return returnString;
  }

  static String getUnitTypeString(UnitTypes unit) {
    switch (unit) {
      case UnitTypes.token:
        return "Tokens";
      case UnitTypes.picture:
        return "Pictures";
      case UnitTypes.character:
        return "Characters";
      case UnitTypes.second:
        return "Seconds";
      case UnitTypes.minute:
        return "Minutes";
      case UnitTypes.hour:
        return "Hours";
      case UnitTypes.day:
        return "Days";
      case UnitTypes.month:
        return "Months";
      case UnitTypes.year:
        return "Years";
      default:
        return "Unknown";
    }
  }
}
