import 'package:rag_tco/data_model/new/price_component.dart';
import 'package:rag_tco/misc/language_model_price_component_types.dart';

class RagComponentLanguageModel {
  RagComponentLanguageModel({required this.name});

  final List<PriceComponent> priceComponents = [];
  String name;

  void addPriceComponentByValue(
      bool isInput,
      LanguageModelPriceComponentTypes type,
      double price,
      double referenceAmount) {
    priceComponents.add(PriceComponent(
        isInput: isInput,
        type: type,
        price: price,
        referenceAmount: referenceAmount));
    priceComponents.sort();
  }

  void addPriceComponentByObject(PriceComponent component) {
    priceComponents.add(component);
    priceComponents.sort();
  }

  double calculateCost(
      bool isInput, LanguageModelPriceComponentTypes type, double amount) {
    PriceComponent? calculateComponent;
    for (PriceComponent component in priceComponents) {
      if (component.isInput == isInput && component.type == type) {
        calculateComponent = component;
      }
    }
    if (calculateComponent == null) {
      return 0;
    } else {
      return calculateComponent.price *
          amount /
          calculateComponent.referenceAmount;
    }
  }

  void removeComponent(PriceComponent component) {
    priceComponents.remove(component);
  }

  String getPriceComponentString() {
    String returnString = "";
    for (int i = 0; i < priceComponents.length; i++) {
      returnString +=
          "${priceComponents[i].isInput ? "Input" : "Output"} ${priceComponents[i].type.parseToString()}:\n${priceComponents[i].price} / ${priceComponents[i].referenceAmount} ${priceComponents[i].type.getUnit(priceComponents[i].referenceAmount != 1)}";
      if (i != priceComponents.length - 1) returnString += "\n";
    }
    return returnString;
  }
}
