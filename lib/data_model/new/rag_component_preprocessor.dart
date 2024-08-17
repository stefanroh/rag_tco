class RagComponentPreprocessor {
  RagComponentPreprocessor(
      {required this.name, required this.costPerOperation});

  String name;
  double costPerOperation;

  double getCost(int operations) {
    return costPerOperation * operations;
  }
}
