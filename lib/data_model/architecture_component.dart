import 'package:rag_tco/calculation/calculated_component.dart';
import 'package:rag_tco/data_model/variable_price_component.dart';

class ArchitectureComponent {
  ArchitectureComponent(this.componentName, this.fixCost, this.currency,
      this.provider, this.type);

  String componentName;

  List<VariablePriceComponent> variablePriceComponents = [];
  double fixCost;
  String currency;
  String provider;
  String type;

  CalculatedComponent calculateVariableCost(
      List<String> quantityFormular, Map<String, dynamic> variables) {
    CalculatedComponent calculatedComponent =
        CalculatedComponent(componentName);
    calculatedComponent.fixCosts = fixCost;

    for (int i = 0; i < variablePriceComponents.length; i++) {
      if (i < quantityFormular.length) {
        double priceComponentCost = variablePriceComponents[i]
            .calculateCost(quantityFormular[i], variables);
        calculatedComponent.addVarCost(
            variablePriceComponents[i].name, priceComponentCost);
      }
    }
    return calculatedComponent;
  }
}
