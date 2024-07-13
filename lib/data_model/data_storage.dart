import 'package:flutter/material.dart';

@immutable
class DataStorage {
  final List<int> serviceProviderReferences;
  final List<double> serviceAmounts;

  const DataStorage(
      {this.serviceProviderReferences = const [],
      this.serviceAmounts = const []});

  DataStorage copyWith(
      {List<int>? newServiceProviderReferences,
      List<double>? newServiceAmounts}) {
    return DataStorage(
        serviceProviderReferences:
            newServiceProviderReferences ?? serviceProviderReferences,
        serviceAmounts: newServiceAmounts ?? serviceAmounts);
  }
}
