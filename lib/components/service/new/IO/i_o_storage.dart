import 'package:rag_tco/components/service/new/IO/i_o_component.dart';
import 'package:rag_tco/misc/language_model_price_component_types.dart';

class IOStorage {
  List<IOComponent> inputComponents = [];
  List<IOComponent> outputComponents = [];

  void setComponent(
      LanguageModelPriceComponentTypes type, bool isInput, double amount) {
    List<IOComponent> componentList =
        isInput ? inputComponents : outputComponents;
    for (int i = 0; i < componentList.length; i++) {
      if (componentList[i].type == type) {
        componentList[i].amount = amount;
        return;
      }
    }
    componentList.add(IOComponent(type: type, amount: amount));
  }

  void removeComponent(LanguageModelPriceComponentTypes type, bool isInput) {
    List<IOComponent> componentList =
        isInput ? inputComponents : outputComponents;
    componentList.removeWhere((element) => element.type == type);
  }

  double getAmountByType(LanguageModelPriceComponentTypes type, bool isInput) {
    List<IOComponent> componentList =
        isInput ? inputComponents : outputComponents;
    for (int i = 0; i < componentList.length; i++) {
      if (componentList[i].type == type) {
        return componentList[i].amount;
      }
    }
    return 0;
  }
}
