class RagComponentVectordb {
  RagComponentVectordb({required this.name, required this.costPerUpdate});

  String name;
  double costPerUpdate;

  double getCost(int updates) {
    return costPerUpdate * updates;
  }
}
