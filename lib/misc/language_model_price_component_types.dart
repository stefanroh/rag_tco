enum LanguageModelPriceComponentTypes { text, picture, video, audio, unknown }

extension LanguageModelPriceComponentTypesUtils
    on LanguageModelPriceComponentTypes {
  String parseToString() {
    //if (this == PriceComponentTypes.unknown) return "Unknown";
    String s = toString().split('.').last;
    return "${s[0].toUpperCase()}${s.substring(1).toLowerCase()}";
  }

  String getUnit(bool plural) {
    switch (this) {
      case LanguageModelPriceComponentTypes.text:
        return plural ? "Tokens" : "Token";
      case LanguageModelPriceComponentTypes.picture:
        return plural ? "Pictures" : "Picture";
      case LanguageModelPriceComponentTypes.video:
        return plural ? "Seconds" : "Second";
      case LanguageModelPriceComponentTypes.audio:
        return plural ? "Seconds" : "Second";
      case LanguageModelPriceComponentTypes.unknown:
        return "Unknown";
    }
  }
}
