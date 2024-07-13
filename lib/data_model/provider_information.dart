import 'package:excel/excel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

@immutable
class ProviderInformation {
  static Future<ProviderInformation> fromExcel(String path) async {
    List<String> serviceName = [];
    List<double> servicePrices = [];

    ByteData data = await rootBundle.load(path);
    var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    var excel = Excel.decodeBytes(bytes);

    var table = excel.tables["data"];
    //Hand Null Check
    for (var row in table!.rows) {
      serviceName.add(row.elementAt(0)!.value.toString());
      servicePrices.add(double.parse(row.elementAt(1)!.value.toString()));
    }

    return ProviderInformation.fromValue(
        serviceName: serviceName, servicePrices: servicePrices);
  }

  // ignore: prefer_const_constructors_in_immutables
  ProviderInformation.fromValue(
      {required this.serviceName, required this.servicePrices});

  late final List<String> serviceName;
  late final List<double> servicePrices;

  ProviderInformation copyWith(
      {List<String>? newNames, List<double>? newPrices}) {
    return ProviderInformation.fromValue(
        serviceName: newNames ?? serviceName,
        servicePrices: newPrices ?? servicePrices);
  }
}
