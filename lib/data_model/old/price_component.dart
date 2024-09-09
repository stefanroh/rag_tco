import 'package:rag_tco/misc/language_model_price_component_types.dart';

class PriceComponent implements Comparable<PriceComponent> {
  PriceComponent(
      {required this.isInput,
      required this.type,
      required this.price,
      required this.referenceAmount})
      : super();

  bool isInput;
  LanguageModelPriceComponentTypes type;
  double price;
  double referenceAmount;

  @override
  int compareTo(PriceComponent other) {
    if (isInput && !other.isInput) return -1;
    if (!isInput && other.isInput) return 1;
    return type.index - other.type.index;
  }

  @override
  String toString() {
    return "Input: $isInput, Type: ${type.parseToString()}";
  }
}
