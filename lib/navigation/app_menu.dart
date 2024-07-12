import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rag_tco/navigation/menu_title.dart';
import 'package:rag_tco/pages/employee.dart';
import 'package:rag_tco/pages/evaluation.dart';
import 'package:rag_tco/pages/failures.dart';
import 'package:rag_tco/navigation/menu_entry.dart';
import 'package:rag_tco/pages/home.dart';
import 'package:rag_tco/pages/implementation.dart';
import 'package:rag_tco/pages/maintainance.dart';
import 'package:rag_tco/pages/reversal.dart';
import 'package:rag_tco/pages/services.dart';
import 'package:rag_tco/pages/strategic.dart';
import 'package:rag_tco/pages/support.dart';
import 'package:rag_tco/pages/training.dart';

final _availablePageName = <int, String>{
  0: "Strategische Entscheidung",
  1: "Evaluation",
  2: "Mitarbiter",
  3: "Implementation",
  4: "Rückabwicklung",
  5: "Servicegebühren",
  6: "Trainign",
  7: "Wartung",
  8: "Systemausfälle",
  9: "Support"
};

// a map of ("page name", WidgetBuilder) pairs
final _availablePrePages = <String, WidgetBuilder>{
  'Strategische Entscheidungen': (_) => const Strategic(),
  'Evaluation': (_) => const Evaluation(),
  'Mitarbeiter': (_) => const Employee(),
};

final _availableMidPages = <String, WidgetBuilder>{
  'Implementation': (_) => const Implementation(),
  'Rückabwicklung': (_) => const Reversal(),
};

final _availablePostPages = <String, WidgetBuilder>{
  'Servicegebühren': (_) => const Services(),
  'Training': (_) => const Training(),
  'Wartung': (_) => const Maintainance(),
  'Systemausfälle': (_) => const Failures(),
  'Support': (_) => const Support(),
};

final _shownPages = <String, bool>{
  'Strategische Entscheidungen': true,
  'Evaluation': true,
  'Mitarbeiter': true,
  'Implementation': true,
  'Rückabwicklung': true,
  'Servicegebühren': true,
  'Training': true,
  'Wartung': true,
  'Systemausfälle': true,
  'Support': true,
};

final selectedPageNameProvider = StateProvider<String>((ref) {
  return 'Home';
});

final selectedPageBuilderProvider = Provider<WidgetBuilder>((ref) {
  // watch for state changes inside selectedPageNameProvider
  final selectedPageKey = ref.watch(selectedPageNameProvider);

  if (_availablePrePages[selectedPageKey] != null) {
    return _availablePrePages[selectedPageKey]!;
  }

  if (_availableMidPages[selectedPageKey] != null) {
    return _availableMidPages[selectedPageKey]!;
  }

  if (_availablePostPages[selectedPageKey] != null) {
    return _availablePostPages[selectedPageKey]!;
  }
  return (_) => const Home();
});

final shownPagesProvider = StateProvider<Map<String, bool>>((ref) {
  return _shownPages;
});

class AppMenu extends ConsumerWidget {
  const AppMenu({super.key});

  void _selectPage(BuildContext context, WidgetRef ref, String pageName) {
    if (ref.read(selectedPageNameProvider) != pageName) {
      ref.read(selectedPageNameProvider.notifier).state = pageName;
    }
  }

  bool showTitle(Map<String, WidgetBuilder> map, Map<String, bool> visibility) {
    for (var key in map.keys) {
      if (visibility[key] == true) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedPageName = ref.watch(selectedPageNameProvider);
    final shownPages = ref.watch(shownPagesProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('RAG Cost Calculator')),
      body: ListView(
        children: <Widget>[
          PageListTile(
            pageName: 'Home',
            selectedPageName: selectedPageName,
            onPressed: () => _selectPage(context, ref, 'Home'),
          ),
          Visibility(
              visible: showTitle(_availablePrePages, shownPages),
              child: const MenuTitle(textString: "Pretransaktionskosten")),
          for (var pageName in _availablePrePages.keys)
            Visibility(
                visible: shownPages[pageName] ?? true,
                child: PageListTile(
                  selectedPageName: selectedPageName,
                  pageName: pageName,
                  onPressed: () => _selectPage(context, ref, pageName),
                )),
          Visibility(
              visible: showTitle(_availableMidPages, shownPages),
              child: const MenuTitle(textString: "Transaktionskosten")),
          for (var pageName in _availableMidPages.keys)
            Visibility(
                visible: shownPages[pageName] ?? true,
                child: PageListTile(
                  selectedPageName: selectedPageName,
                  pageName: pageName,
                  onPressed: () => _selectPage(context, ref, pageName),
                )),
          Visibility(
              visible: showTitle(_availablePostPages, shownPages),
              child: const MenuTitle(textString: "Posttransaktionskosten")),
          for (var pageName in _availablePostPages.keys)
            Visibility(
                visible: shownPages[pageName] ?? true,
                child: PageListTile(
                  selectedPageName: selectedPageName,
                  pageName: pageName,
                  onPressed: () => _selectPage(context, ref, pageName),
                )),
        ],
      ),
    );
  }
}
