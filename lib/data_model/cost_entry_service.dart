import 'package:rag_tco/data_model/cost_entry.dart';

class CostEntryService extends CostEntry {
  int _providerReference;
  List<double> _amounts;

  CostEntryService(
      {required providerReference,
      required List<double> amounts,
      required String entryName})
      : _providerReference = providerReference,
        _amounts = amounts,
        super(entryName);

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
