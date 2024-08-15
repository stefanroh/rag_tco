enum UnitTypesLegacy {
  token,
  character,
  picture,
  second,
  unknown
}

extension UnitTypesUtils on UnitTypesLegacy {
  String parseToString() {
    if (this == UnitTypesLegacy.unknown) return "Unknown";
    String s = toString().split('.').last;
    return "${s[0].toUpperCase()}${s.substring(1).toLowerCase()}";
  }

}
