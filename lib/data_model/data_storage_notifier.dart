import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rag_tco/data_model/data_storage.dart';

class DataStorageNotifier extends Notifier<DataStorage> {
  DataStorageNotifier() : super();

  addService(int addedServiceProviderReference, double addedAmount) {
    List<int> serviceProviderIndex =
        List<int>.from(state.serviceProviderReferences);
    List<double> serviceAmounts = List<double>.from(state.serviceAmounts);

    serviceProviderIndex.add(addedServiceProviderReference);
    serviceAmounts.add(addedAmount);

    state = state.copyWith(
        newServiceProviderReferences: serviceProviderIndex,
        newServiceAmounts: serviceAmounts);
  }

  @override
  build() {
    return const DataStorage();
  }
}
