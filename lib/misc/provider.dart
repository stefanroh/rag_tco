import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rag_tco/data_model/old/data_storage.dart';
import 'package:rag_tco/data_model/old/data_storage_notifier.dart';
import 'package:rag_tco/data_model/new/rag_components.dart';
import 'package:rag_tco/data_model/new/rag_components_notifier.dart';
import 'package:rag_tco/data_model/old/provider_information.dart';
import 'package:rag_tco/data_model/old/provider_information_notifier.dart';
import 'package:rag_tco/data_model/old/report_storage.dart';
import 'package:rag_tco/data_model/old/report_storage_notifier.dart';
import 'package:rag_tco/navigation/app_menu.dart';

final selectedPageIndexProvider = StateProvider<int>((ref) {
  return 0;
});

final shownPagesProvider = StateProvider<Map<int, bool>>((ref) {
  return shownPages;
});

final providerInformationProvider =
    AsyncNotifierProvider<ProviderInformationNotifier, ProviderInformation>(() {
  return ProviderInformationNotifier();
});

final ragComponentsProvider =
    AsyncNotifierProvider<RagComponentsNotifier, RagComponents>(() {
  return RagComponentsNotifier();
});

final dataStorageProvider =
    NotifierProvider<DataStorageNotifier, DataStorage>(() {
  return DataStorageNotifier();
});

final reportStorageProvider =
    NotifierProvider<ReportStorageNotifier, ReportStorage>(() {
  return ReportStorageNotifier();
});
