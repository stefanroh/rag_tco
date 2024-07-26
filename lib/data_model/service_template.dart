import 'package:rag_tco/data_model/unit_types.dart';

class ServiceTemplate {
  ServiceTemplate(
      {required this.templateName,
      required this.componentNames,
      required this.componentUnits,
      required this.componentAmounts});

  String templateName;
  List<String> componentNames;
  List<UnitTypes> componentUnits;
  List<double> componentAmounts;
}
