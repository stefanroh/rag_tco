class RagComponentStorage {
  RagComponentStorage({required this.name, required this.costPerGB});

  String name;
  double costPerGB;

  double getCost(double storageVolume) {
    return costPerGB * storageVolume;
  }
}
