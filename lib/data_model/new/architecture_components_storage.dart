import 'package:rag_tco/data_model/new/architecture_component.dart';

class ArchitectureComponentsStorage {
  ArchitectureComponentsStorage(this.componentList);

  List<ArchitectureComponent> componentList;

  ArchitectureComponentsStorage copyWith(List<ArchitectureComponent> newComponentList) {
    return ArchitectureComponentsStorage(newComponentList);
  }
}
