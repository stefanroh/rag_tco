import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rag_tco/data_model/new/architecture_component.dart';
import 'package:rag_tco/data_model/new/architecture_components_storage.dart';
import 'package:rag_tco/data_model/new/variable_price_component.dart';

class ArchitectureComponentsNotifier
    extends AsyncNotifier<ArchitectureComponentsStorage> {
  @override
  FutureOr<ArchitectureComponentsStorage> build() {
    return ArchitectureComponentsStorage.loadData();
  }

  void addArchitectureComponent(ArchitectureComponent component) {
    List<ArchitectureComponent> componentList =
        List<ArchitectureComponent>.from(state.value!.componentList);

    componentList.add(component);
    state = AsyncValue.data(state.value!.copyWith(componentList));
  }

  void removeArchitectureComponent(ArchitectureComponent component) {
    List<ArchitectureComponent> componentList =
        List<ArchitectureComponent>.from(state.value!.componentList);

    componentList.removeWhere((element) => element == component);

    state = AsyncValue.data(state.value!.copyWith(componentList));
  }

  void updateArchitectureComponent(
      ArchitectureComponent component,
      String? newName,
      double? newFixCost,
      String? newProvider,
      String? newType) {
    List<ArchitectureComponent> componentList =
        List<ArchitectureComponent>.from(state.value!.componentList);

    component.componentName = newName ?? component.componentName;
    component.fixCost = newFixCost ?? component.fixCost;
    component.provider = newProvider ?? component.provider;
    component.type = newType ?? component.type;
    state = AsyncValue.data(state.value!.copyWith(componentList));
  }

  void addVariablePriceComponent(ArchitectureComponent architectureComponent,
      VariablePriceComponent priceComponent) {
    List<ArchitectureComponent> componentList =
        List<ArchitectureComponent>.from(state.value!.componentList);

    architectureComponent.variablePriceComponents.add(priceComponent);
    state = AsyncValue.data(state.value!.copyWith(componentList));
  }

  void removeVariablePriceComponent(ArchitectureComponent architectureComponent,
      VariablePriceComponent priceComponent) {
    List<ArchitectureComponent> componentList =
        List<ArchitectureComponent>.from(state.value!.componentList);

    architectureComponent.variablePriceComponents
        .removeWhere((element) => element == priceComponent);
    state = AsyncValue.data(state.value!.copyWith(componentList));
  }

  void updateVariablePriceComponent(VariablePriceComponent priceComponent,
      {String? newName,
      double? newPrice,
      double? newReferenceAmount,
      double? newInclusiveAmount,
      double? newMinAmount,
      bool? newOnlyFullUnit,
      String? newFormular}) {
    List<ArchitectureComponent> componentList =
        List<ArchitectureComponent>.from(state.value!.componentList);

    priceComponent.name = newName ?? priceComponent.name;
    priceComponent.price = newPrice ?? priceComponent.price;
    priceComponent.referenceAmount =
        newReferenceAmount ?? priceComponent.referenceAmount;
    priceComponent.inclusiveAmount =
        newInclusiveAmount ?? priceComponent.inclusiveAmount;
    priceComponent.minAmount = newMinAmount ?? priceComponent.minAmount;
    priceComponent.onlyFullUnits =
        newOnlyFullUnit ?? priceComponent.onlyFullUnits;
    priceComponent.quantityFormular =
        newFormular ?? priceComponent.quantityFormular;

    state = AsyncValue.data(state.value!.copyWith(componentList));
  }
}
