import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rag_tco/data_model/architecture_components_notifier.dart';
import 'package:rag_tco/data_model/architecture_components_storage.dart';

final selectedPageIndexProvider = StateProvider<int>((ref) {
  return 0;
});

final architectureComponentProvider = AsyncNotifierProvider<
    ArchitectureComponentsNotifier, ArchitectureComponentsStorage>(() {
  return ArchitectureComponentsNotifier();
});
