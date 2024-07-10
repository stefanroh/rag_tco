// app_menu.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rag_tco/pages/first_page.dart';
import 'package:rag_tco/navigation/page_list_title.dart';
import 'package:rag_tco/pages/second_page.dart';

// a map of ("page name", WidgetBuilder) pairs
final _availablePages = <String, WidgetBuilder>{
  'First Page': (_) => const FirstPage(),
  'Second Page': (_) => const SecondPage(),
};

final selectedPageNameProvider = StateProvider<String>((ref) {
  return _availablePages.keys.first;
});

final selectedPageBuilderProvider = Provider<WidgetBuilder>((ref) {
  // watch for state changes inside selectedPageNameProvider
  final selectedPageKey = ref.watch(selectedPageNameProvider);
  // return the WidgetBuilder using the key as index
  return _availablePages[selectedPageKey]!;
});

class AppMenu extends ConsumerWidget {
  const AppMenu({super.key});

  void _selectPage(BuildContext context, WidgetRef ref, String pageName) {
    if (ref.read(selectedPageNameProvider) != pageName) {
      ref.read(selectedPageNameProvider.notifier).state = pageName;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedPageName = ref.watch(selectedPageNameProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Menu')),
      body: ListView(
        // Note: use ListView.builder if there are many items
        children: <Widget>[
          // iterate through the keys to get the page names
          for (var pageName in _availablePages.keys)
            PageListTile(
              selectedPageName: selectedPageName,
              pageName: pageName,
              onPressed: () => _selectPage(context, ref, pageName),
            ),
        ],
      ),
    );
  }
}
