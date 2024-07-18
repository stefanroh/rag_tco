import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rag_tco/data_model/data_storage.dart';
import 'package:rag_tco/data_model/cost_entry_service.dart';

class DataStorageNotifier extends Notifier<DataStorage> {
  DataStorageNotifier() : super();

  void addServiceEntry(
      int addedServiceProviderReference, List<double> addedAmounts) {
    List<CostEntryService> serviceEntries =
        List<CostEntryService>.from(state.serviceEntries);

    serviceEntries.add(CostEntryService(
        providerReference: addedServiceProviderReference,
        amounts: addedAmounts));

    state = state.copyWith(newServiceEntries: serviceEntries);
  }

  void removeServiceEntry(int serviceEntryIndex) {
    List<CostEntryService> serviceEntries =
        List<CostEntryService>.from(state.serviceEntries);

    serviceEntries.removeAt(serviceEntryIndex);
    state = state.copyWith(newServiceEntries: serviceEntries);
  }

  void removeServiceEntryByProvider(int providerIndex) {
    List<CostEntryService> serviceEntries =
        List<CostEntryService>.from(state.serviceEntries);

    //Remove Entries that refers to the provider
    for (int i = serviceEntries.length - 1; i >= 0; i--) {
      if (serviceEntries[i].getProviderReference() == providerIndex) {
        serviceEntries.removeAt(i);
      } else if (serviceEntries[i].getProviderReference() > providerIndex) {
        serviceEntries[i]
            .setProviderReference(serviceEntries[i].getProviderReference() - 1);
      }
    }
    log(serviceEntries.toString());
    state = state.copyWith(newServiceEntries: serviceEntries);
  }

  void addServiceComponent(int providerIndex) {
    List<CostEntryService> serviceEntries =
        List<CostEntryService>.from(state.serviceEntries);
    for (int i = 0; i < serviceEntries.length; i++) {
      if (serviceEntries[i].getProviderReference() == providerIndex) {
        serviceEntries[i].addComponent();
      }
    }
    state = state.copyWith(newServiceEntries: serviceEntries);
  }

  void removeServiceComponent(int providerIndex, int componentIndex) {
    List<CostEntryService> serviceEntries =
        List<CostEntryService>.from(state.serviceEntries);
    for (int i = 0; i < serviceEntries.length; i++) {
      if (serviceEntries[i].getProviderReference() == providerIndex) {
        serviceEntries[i].removeComponent(componentIndex);
      }
    }
    state = state.copyWith(newServiceEntries: serviceEntries);
  }

  void updateServiceAmounts(int serviceEntryIndex, List<double> newAmounts) {
    List<CostEntryService> serviceEntries =
        List<CostEntryService>.from(state.serviceEntries);
    serviceEntries[serviceEntryIndex].setAmounts(newAmounts);
    state = state.copyWith(newServiceEntries: serviceEntries);
  }

  @override
  build() {
    return const DataStorage();
  }
}
