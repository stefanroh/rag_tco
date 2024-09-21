import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:rag_tco/data_model/new/architecture_component.dart';
import 'package:rag_tco/data_model/new/variable_price_component.dart';

class ArchitectureComponentsStorage {
  ArchitectureComponentsStorage(this.componentList);

  List<ArchitectureComponent> componentList;

  static Future<ArchitectureComponentsStorage> loadData() async {
    final String response = await rootBundle.loadString("assets/data.json");
    final data = await json.decode(response);

    List<ArchitectureComponent> componentList = [];

    for (String compKey in data.keys) {
      ArchitectureComponent component =
          ArchitectureComponent(compKey, data[compKey]["fixCost"], data[compKey]["currency"]);
      for (int i = 0; i < data[compKey]["variableCosts"].length; i++) {
        var varComponent = data[compKey]["variableCosts"][i];
        String name = varComponent["name"];
        double price = varComponent["price"];
        double refAmount = varComponent["referenceAmount"];
        bool onlyFullUnits = varComponent["onlyFullUnits"];
        double inclusiveAmount = varComponent["inclusiveAmount"];
        double minAmount = varComponent["minAmount"];
        String defaultFormular = varComponent["defaultFormular"];
        VariablePriceComponent priceComponent = VariablePriceComponent(
            name,
            price,
            refAmount,
            onlyFullUnits,
            inclusiveAmount,
            minAmount,
            defaultFormular);
        component.variablePriceComponents.add(priceComponent);
      }
      componentList.add(component);
    }

    return ArchitectureComponentsStorage(componentList);
  }

  ArchitectureComponentsStorage copyWith(
      List<ArchitectureComponent> newComponentList) {
    return ArchitectureComponentsStorage(newComponentList);
  }
}
