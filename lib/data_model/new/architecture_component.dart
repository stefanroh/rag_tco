import 'package:rag_tco/data_model/new/variable_price_component.dart';

class ArchitectureComponent {
  ArchitectureComponent(this.componentName, this.fixCost);

  String componentName;

  List<VariablePriceComponent> variablePriceComponents = [];
  double fixCost;
}
