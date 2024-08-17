import 'package:rag_tco/data_model/new/rag_component_language_model.dart';

class RagComponentVectordb {
  RagComponentVectordb({required this.name, required this.costPerUpdate});

  String name;
  double costPerUpdate;

  double getCost(int updates) {
    return costPerUpdate * updates;
  }
}
