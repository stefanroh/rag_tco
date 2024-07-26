import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rag_tco/navigation/menu_entry.dart';
import 'package:rag_tco/navigation/menu_title.dart';
import 'package:rag_tco/misc/provider.dart';
import 'package:rag_tco/pages/employee.dart';
import 'package:rag_tco/pages/evaluation.dart';
import 'package:rag_tco/pages/failures.dart';
import 'package:rag_tco/pages/implementation.dart';
import 'package:rag_tco/pages/maintainance.dart';
import 'package:rag_tco/pages/reversal.dart';
import 'package:rag_tco/pages/services.dart';
import 'package:rag_tco/pages/strategic.dart';
import 'package:rag_tco/pages/support.dart';
import 'package:rag_tco/pages/training.dart';

final pageNames = <int, String>{
  0: "Home",
  1: "Strategische Entscheidung",
  2: "Evaluation",
  3: "Mitarbeiter",
  4: "Implementation",
  5: "Rückabwicklung",
  6: "Servicegebühren",
  7: "Training",
  8: "Wartung",
  9: "Systemausfälle",
  10: "Support",
  11: "Report"
};

// a map of ("page name", WidgetBuilder) pairs
final prePages = <int, WidgetBuilder>{
  1: (_) => const Strategic(),
  2: (_) => const Evaluation(),
  3: (_) => const Employee(),
};

final midPages = <int, WidgetBuilder>{
  4: (_) => const Implementation(),
  5: (_) => const Reversal(),
};

final postPages = <int, WidgetBuilder>{
  6: (_) => const Services(),
  7: (_) => const Training(),
  8: (_) => const Maintainance(),
  9: (_) => const Failures(),
  10: (_) => const Support(),
};

final shownPages = <int, bool>{
  1: true,
  2: true,
  3: true,
  4: true,
  5: true,
  6: true,
  7: true,
  8: true,
  9: true,
  10: true,
};

class AppMenu extends ConsumerWidget {
  const AppMenu({super.key});

  void _selectPage(BuildContext context, WidgetRef ref, int pageIndex) {
    if (ref.read(selectedPageIndexProvider) != pageIndex) {
      ref.read(selectedPageIndexProvider.notifier).state = pageIndex;
    }
  }

  bool showTitle(Map<int, WidgetBuilder> map, Map<int, bool> visibility) {
    for (var key in map.keys) {
      if (visibility[key] == true) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedPageIndex = ref.watch(selectedPageIndexProvider);
    final shownPages = ref.watch(shownPagesProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('RAG Cost Calculator')),
      body: ListView(
        children: <Widget>[
          MenuEntry(
            pageIndex: 0,
            selectedPageIndex: selectedPageIndex,
            onPressed: () => _selectPage(context, ref, 0),
          ),
          Visibility(
              visible: showTitle(prePages, shownPages),
              child: const MenuTitle(textString: "Pretransaktionskosten")),
          for (var pageIndex in prePages.keys)
            Visibility(
                visible: shownPages[pageIndex] ?? true,
                child: MenuEntry(
                  selectedPageIndex: selectedPageIndex,
                  pageIndex: pageIndex,
                  onPressed: () => _selectPage(context, ref, pageIndex),
                )),
          Visibility(
              visible: showTitle(midPages, shownPages),
              child: const MenuTitle(textString: "Transaktionskosten")),
          for (var pageIndex in midPages.keys)
            Visibility(
                visible: shownPages[pageIndex] ?? true,
                child: MenuEntry(
                  selectedPageIndex: selectedPageIndex,
                  pageIndex: pageIndex,
                  onPressed: () => _selectPage(context, ref, pageIndex),
                )),
          Visibility(
              visible: showTitle(postPages, shownPages),
              child: const MenuTitle(textString: "Posttransaktionskosten")),
          for (var pageIndex in postPages.keys)
            Visibility(
                visible: shownPages[pageIndex] ?? true,
                child: MenuEntry(
                  selectedPageIndex: selectedPageIndex,
                  pageIndex: pageIndex,
                  onPressed: () => _selectPage(context, ref, pageIndex),
                )),
          Container(
            margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: const Divider(),
          ),
          MenuEntry(
              pageIndex: 11,
              selectedPageIndex: selectedPageIndex,
              onPressed: () => _selectPage(context, ref, 11))
        ],
      ),
    );
  }
}
