import 'package:rag_tco/data_model/old/cost_entry.dart';
import 'package:rag_tco/data_model/old/timeframe_type.dart';

class CostEntryService extends CostEntry {
  int _providerReference;
  List<double> _amounts;
  TimeframeType referenceTimeframe;
  int frequency;

  CostEntryService(
      {required providerReference,
      required List<double> amounts,
      required String entryName,
      required this.referenceTimeframe,
      required this.frequency})
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
