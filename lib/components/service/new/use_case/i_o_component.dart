import 'package:rag_tco/misc/language_model_price_component_types.dart';

class IOComponent{
  IOComponent({required this.type, required this.amount});

  LanguageModelPriceComponentTypes type;
  int amount;
}