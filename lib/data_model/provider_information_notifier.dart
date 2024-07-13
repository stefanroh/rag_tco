import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rag_tco/data_model/provider_information.dart';

class ProviderInformationNotifier extends AsyncNotifier<ProviderInformation> {
  ProviderInformationNotifier() : super();

  void addServicePrice(String name, double price) {
    List<String> serviceNames = List.from(state.value!.serviceName);
    List<double> servicePrices = List.from(state.value!.servicePrices);

    servicePrices.add(price);
    serviceNames.add(name);

    state = AsyncValue.data(state.value!
        .copyWith(newNames: serviceNames, newPrices: servicePrices));
  }

  @override
  FutureOr<ProviderInformation> build() {
    return ProviderInformation.fromExcel("assets/provider_information.xlsx");
  }
}
