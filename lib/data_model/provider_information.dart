import 'package:excel/excel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

@immutable
class ProviderInformation {
  static Future<ProviderInformation> fromExcel(String path) async {
    List<String> serviceName = [];
    List<List<String>> serviceComponentNames = [[]];
    List<List<double>> serviceComponentPrices = [[]];
    List<List<String>> serviceComponentUnit = [[]];

    ByteData data = await rootBundle.load(path);
    var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    var excel = Excel.decodeBytes(bytes);

    var table = excel.tables["data"];
    //Hand Null Check
    int rowIndex = 0;
    for (var row in table!.rows) {
      serviceName.add(row.elementAt(0)!.value.toString());
      serviceComponentNames.add([]);
      serviceComponentPrices.add([]);
      serviceComponentUnit.add([]);
      for (var columnIndex = 1;
          columnIndex + 2 < row.length;
          columnIndex = columnIndex + 3) {
        Data nameCell = row.elementAt(columnIndex)!;
        Data priceCell = row.elementAt(columnIndex + 1)!;
        Data unitCell = row.elementAt(columnIndex + 2)!;
        serviceComponentNames[rowIndex].add(nameCell.value.toString());
        serviceComponentPrices[rowIndex]
            .add(double.parse(priceCell.value.toString()));
        serviceComponentUnit[rowIndex].add(unitCell.value.toString());
      }
      rowIndex++;
    }

    return ProviderInformation.fromValue(
        serviceName: serviceName,
        serviceComponentNames: serviceComponentNames,
        serviceComponentPrices: serviceComponentPrices,
        serviceComponentUnits: serviceComponentUnit);
  }

  // ignore: prefer_const_constructors_in_immutables
  ProviderInformation.fromValue(
      {required this.serviceName,
      required this.serviceComponentNames,
      required this.serviceComponentPrices,
      required this.serviceComponentUnits});

  late final List<String> serviceName;
  late final List<List<String>> serviceComponentNames;
  late final List<List<double>> serviceComponentPrices;
  late final List<List<String>> serviceComponentUnits;

  ProviderInformation copyWith(
      {List<String>? newNames,
      List<List<String>>? newComponentNames,
      List<List<double>>? newComponentPrices,
      List<List<String>>? newComponentUnits}) {
    return ProviderInformation.fromValue(
        serviceName: newNames ?? serviceName,
        serviceComponentNames: newComponentNames ?? serviceComponentNames,
        serviceComponentPrices: newComponentPrices ?? serviceComponentPrices,
        serviceComponentUnits: newComponentUnits ?? serviceComponentUnits);
  }
}
