import 'package:rag_tco/components/service/old/use_case/i_o_component.dart';
import 'package:rag_tco/misc/language_model_price_component_types.dart';

class UseCaseStorage {
  List<IOComponent> inputComponents = [];
  List<IOComponent> outputComponents = [];
  int frequency = 1;
  int storageAmount = 0;
  int vectorDBUpdate = 0;
  int preprocessorOperation = 0;

  void setComponent(
      LanguageModelPriceComponentTypes type, bool isInput, int amount) {
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

  int getAmountByType(LanguageModelPriceComponentTypes type, bool isInput) {
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
