class VariablePriceComponent {
  VariablePriceComponent(this.name, this.price, this.referenceAmount, this.onlyFullAmounts,
      this.inclusiveAmount, this.minAmount, this.quantityFormular);

  String name;
  double price;
  double referenceAmount;
  bool onlyFullAmounts;
  double inclusiveAmount;
  double minAmount;
  String quantityFormular;
}
