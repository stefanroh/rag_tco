import 'package:rag_tco/data_model/old/unit_types_legacy.dart';

class ServiceTemplate {
  ServiceTemplate(
      {required this.templateName,
      required this.componentNames,
      required this.componentUnits,
      required this.componentAmounts});

  String templateName;
  List<String> componentNames;
  List<UnitTypesLegacy> componentUnits;
  List<double> componentAmounts;
}
