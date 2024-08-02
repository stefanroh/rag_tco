class ReportConfiguration {
  String configurationName;

  List<int> selectedStrategic;
  List<int> selectedEvaluation;
  List<int> selectedEmployee;
  List<int> selectedImplementation;
  List<int> selectedReversal;
  List<int> selectedService;
  List<int> selectedTraining;
  List<int> selectedMaintainance;
  List<int> selectedFailure;
  List<int> selectedSupport;

  ReportConfiguration(
      {required this.configurationName,
      this.selectedStrategic = const [],
      this.selectedEvaluation = const [],
      this.selectedEmployee = const [],
      this.selectedImplementation = const [],
      this.selectedReversal = const [],
      this.selectedService = const [],
      this.selectedTraining = const [],
      this.selectedMaintainance = const [],
      this.selectedFailure = const [],
      this.selectedSupport = const []});
}
