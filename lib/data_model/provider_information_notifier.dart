import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rag_tco/data_model/provider_information.dart';

class ProviderInformationNotifier extends AsyncNotifier<ProviderInformation> {
  ProviderInformationNotifier() : super();

  void addServiceProvider(String name) {
    List<String> serviceNames = List.from(state.value!.serviceName);
    List<List<String>> serviceComponentNames =
        List.from(state.value!.serviceComponentNames);
    List<List<double>> serviceComponentPrices =
        List.from(state.value!.serviceComponentPrices);
    List<List<String>> serviceComponentUnits =
        List.from(state.value!.serviceComponentUnits);

    serviceNames.add(name);
    serviceComponentNames.add([]);
    serviceComponentPrices.add([]);
    serviceComponentUnits.add([]);

    state = AsyncValue.data(state.value!.copyWith(
        newNames: serviceNames,
        newComponentNames: serviceComponentNames,
        newComponentPrices: serviceComponentPrices,
        newComponentUnits: serviceComponentUnits));
  }

  void addServiceComponent(int providerIndex, String componentName,
      double componentPrice, String componentUnit) {
    List<List<String>> serviceComponentNames =
        List.from(state.value!.serviceComponentNames);
    List<List<double>> serviceComponentPrices =
        List.from(state.value!.serviceComponentPrices);
    List<List<String>> serviceComponentUnits =
        List.from(state.value!.serviceComponentUnits);

    serviceComponentNames[providerIndex].add(componentName);
    serviceComponentPrices[providerIndex].add(componentPrice);
    serviceComponentUnits[providerIndex].add(componentUnit);

    state = AsyncValue.data(state.value!.copyWith(
        newComponentNames: serviceComponentNames,
        newComponentPrices: serviceComponentPrices,
        newComponentUnits: serviceComponentUnits));
  }

  void removeServiceComponent(int providerIndex, int componentIndex) {
    List<List<String>> serviceComponentNames =
        List.from(state.value!.serviceComponentNames);
    List<List<double>> serviceComponentPrices =
        List.from(state.value!.serviceComponentPrices);
    List<List<String>> serviceComponentUnits =
        List.from(state.value!.serviceComponentUnits);

    serviceComponentNames[providerIndex].removeAt(componentIndex);
    serviceComponentPrices[providerIndex].removeAt(componentIndex);
    serviceComponentUnits[providerIndex].removeAt(componentIndex);

    state = AsyncValue.data(state.value!.copyWith(
        newComponentNames: serviceComponentNames,
        newComponentPrices: serviceComponentPrices,
        newComponentUnits: serviceComponentUnits));
  }

  @override
  FutureOr<ProviderInformation> build() {
    return ProviderInformation.fromExcel("assets/provider_information.xlsx");
  }
}
