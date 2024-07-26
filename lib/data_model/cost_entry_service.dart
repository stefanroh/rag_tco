class CostEntryService {
  String entryName;
  int _providerReference;
  List<double> _amounts;

  CostEntryService({required providerReference, required List<double> amounts, required this.entryName})
      : _providerReference = providerReference,
        _amounts = amounts;

  void removeComponent(int componentIndex) {
    _amounts.removeAt(componentIndex);
  }

  void editComponent(int componentIndex, double amount) {
    _amounts[componentIndex] = amount;
  }

  void addComponent() {
    _amounts.add(0);
  }

  double getAmount(int componentIndex) {
    return _amounts[componentIndex];
  }

  int getProviderReference() {
    return _providerReference;
  }

  void setProviderReference(int newProviderIndex) {
    _providerReference = newProviderIndex;
  }

  List<double> getAmounts() {
    return _amounts;
  }

  void setAmounts(List<double> newAmounts) {
    _amounts = newAmounts;
  }
}
