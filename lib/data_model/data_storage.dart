import 'package:flutter/material.dart';
import 'package:rag_tco/data_model/cost_entry_service.dart';

@immutable
class DataStorage {
  final List<String> strategicEntries;
  final List<String> evaluationEntries;
  final List<String> employeeEntries;
  final List<String> implementationEntries;
  final List<String> reversalEntries;
  final List<CostEntryService> serviceEntries;
  final List<String> trainingEntries;
  final List<String> maintainanceEntries;
  final List<String> failureEntries;
  final List<String> supportEntries;

  const DataStorage(
      {this.strategicEntries = const [],
      this.evaluationEntries = const [],
      this.employeeEntries = const [],
      this.implementationEntries = const [],
      this.reversalEntries = const [],
      this.trainingEntries = const [],
      this.maintainanceEntries = const [],
      this.failureEntries = const [],
      this.supportEntries = const [],
      this.serviceEntries = const []});

  DataStorage copyWith(
      {List<String>? newStategicEntries,
      List<String>? newEvaluationEntries,
      List<String>? newEmployeeEntries,
      List<String>? newImplementationEntries,
      List<String>? newReversalEntries,
      List<String>? newSupportEntries,
      List<String>? newTrainingEntries,
      List<String>? newMaintainanceEntries,
      List<String>? newFailureEntries,
      List<CostEntryService>? newServiceEntries}) {
    return DataStorage(
        strategicEntries: newStategicEntries ?? strategicEntries,
        evaluationEntries: newEvaluationEntries ?? evaluationEntries,
        employeeEntries: newEmployeeEntries ?? employeeEntries,
        serviceEntries: newServiceEntries ?? serviceEntries,
        implementationEntries:
            newImplementationEntries ?? implementationEntries,
        reversalEntries: newReversalEntries ?? reversalEntries,
        trainingEntries: newTrainingEntries ?? trainingEntries,
        maintainanceEntries: newMaintainanceEntries ?? maintainanceEntries,
        failureEntries: newFailureEntries ?? failureEntries,
        supportEntries: newSupportEntries ?? supportEntries);
  }
}
