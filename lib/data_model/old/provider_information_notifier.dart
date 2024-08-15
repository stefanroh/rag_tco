import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rag_tco/data_model/old/provider_information.dart';
import 'package:rag_tco/data_model/old/unit_types_legacy.dart';

class ProviderInformationNotifier extends AsyncNotifier<ProviderInformation> {
  ProviderInformationNotifier() : super();

  void addServiceProvider(String name) {
    List<String> serviceNames = List.from(state.value!.serviceName);
    List<List<String>> serviceComponentNames =
        List.from(state.value!.serviceComponentNames);
    List<List<double>> serviceComponentPrices =
        List.from(state.value!.serviceComponentPrices);
    List<List<UnitTypesLegacy>> serviceComponentUnits =
        List.from(state.value!.serviceComponentUnits);
    List<List<int>> serviceComponentAmounts =
        List.from(state.value!.serviceComponentAmounts);

    serviceNames.add(name);
    serviceComponentNames.add([]);
    serviceComponentPrices.add([]);
    serviceComponentUnits.add([]);
    serviceComponentAmounts.add([]);

    state = AsyncValue.data(state.value!.copyWith(
        newNames: serviceNames,
        newComponentNames: serviceComponentNames,
        newComponentPrices: serviceComponentPrices,
        newComponentUnits: serviceComponentUnits,
        newComponentAmounts: serviceComponentAmounts));
  }

  void removeServiceProvider(int providerIndex) {
    List<String> serviceNames = List.from(state.value!.serviceName);
    List<List<String>> serviceComponentNames =
        List.from(state.value!.serviceComponentNames);
    List<List<double>> serviceComponentPrices =
        List.from(state.value!.serviceComponentPrices);
    List<List<UnitTypesLegacy>> serviceComponentUnits =
        List.from(state.value!.serviceComponentUnits);
    List<List<int>> serviceComponentAmounts =
        List.from(state.value!.serviceComponentAmounts);

    serviceNames.removeAt(providerIndex);
    serviceComponentNames.removeAt(providerIndex);
    serviceComponentPrices.removeAt(providerIndex);
    serviceComponentUnits.removeAt(providerIndex);
    serviceComponentAmounts.removeAt(providerIndex);

    state = AsyncValue.data(state.value!.copyWith(
        newNames: serviceNames,
        newComponentNames: serviceComponentNames,
        newComponentPrices: serviceComponentPrices,
        newComponentUnits: serviceComponentUnits,
        newComponentAmounts: serviceComponentAmounts));
  }

  void addServiceComponent(int providerIndex, String componentName,
      double componentPrice, UnitTypesLegacy componentUnit, int componentAmount) {
    List<List<String>> serviceComponentNames =
        List.from(state.value!.serviceComponentNames);
    List<List<double>> serviceComponentPrices =
        List.from(state.value!.serviceComponentPrices);
    List<List<UnitTypesLegacy>> serviceComponentUnits =
        List.from(state.value!.serviceComponentUnits);
    List<List<int>> serviceComponentAmounts =
        List.from(state.value!.serviceComponentAmounts);

    serviceComponentNames[providerIndex].add(componentName);
    serviceComponentPrices[providerIndex].add(componentPrice);
    serviceComponentUnits[providerIndex].add(componentUnit);
    serviceComponentAmounts[providerIndex].add(componentAmount);

    state = AsyncValue.data(state.value!.copyWith(
        newComponentNames: serviceComponentNames,
        newComponentPrices: serviceComponentPrices,
        newComponentUnits: serviceComponentUnits,
        newComponentAmounts: serviceComponentAmounts));
  }

  void removeServiceComponent(int providerIndex, int componentIndex) {
    List<List<String>> serviceComponentNames =
        List.from(state.value!.serviceComponentNames);
    List<List<double>> serviceComponentPrices =
        List.from(state.value!.serviceComponentPrices);
    List<List<UnitTypesLegacy>> serviceComponentUnits =
        List.from(state.value!.serviceComponentUnits);
    List<List<int>> serviceComponentAmounts =
        List.from(state.value!.serviceComponentAmounts);

    serviceComponentNames[providerIndex].removeAt(componentIndex);
    serviceComponentPrices[providerIndex].removeAt(componentIndex);
    serviceComponentUnits[providerIndex].removeAt(componentIndex);
    serviceComponentAmounts[providerIndex].removeAt(componentIndex);

    state = AsyncValue.data(state.value!.copyWith(
        newComponentNames: serviceComponentNames,
        newComponentPrices: serviceComponentPrices,
        newComponentUnits: serviceComponentUnits,
        newComponentAmounts: serviceComponentAmounts));
  }

  @override
  FutureOr<ProviderInformation> build() {
    return ProviderInformation.fromExcel("assets/data.xlsx");
  }
}
