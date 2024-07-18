import 'package:flutter/material.dart';
import 'package:rag_tco/data_model/cost_entry_service.dart';

@immutable
class DataStorage {
  final List<CostEntryService> serviceEntries;

  const DataStorage(
      {this.serviceEntries = const []});

  DataStorage copyWith(
      {List<CostEntryService>? newServiceEntries}) {
    return DataStorage(
        serviceEntries: newServiceEntries ?? serviceEntries);
  }
}
