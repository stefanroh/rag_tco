import 'package:rag_tco/data_model/new/architecture_component.dart';

class UseCaseStorage {
  List<ArchitectureComponent> components = [];
  List<List<String>> quantityFormulars = [];

  void addComponent(
      ArchitectureComponent component, List<String> quantityFormular) {
    components.add(component);
    quantityFormulars.add(quantityFormular);
  }

  void updateFormulars(int i, List<String> newFormulars) {
    quantityFormulars[i] = newFormulars;
  }

  int getComponentCount() {
    return components.length;
  }

  void removeComponent(int i) {
    components.removeAt(i);
    quantityFormulars.removeAt(i);
  }
}
