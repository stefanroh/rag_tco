class ReportConfiguration {
  String configurationName;

  int selectedStrategic;
  int selectedEvaluation;
  int selectedEmployee;
  int selectedImplementation;
  int selectedReversal;
  int selectedService;
  int selectedTraining;
  int selectedMaintainance;
  int selectedFailure;
  int selectedSupport;

  ReportConfiguration(
      {required this.configurationName,
      this.selectedStrategic = -1,
      this.selectedEvaluation = -1,
      this.selectedEmployee = -1,
      this.selectedImplementation = -1,
      this.selectedReversal = -1,
      this.selectedService = -1,
      this.selectedTraining = -1,
      this.selectedMaintainance = -1,
      this.selectedFailure = -1,
      this.selectedSupport = -1});
}
