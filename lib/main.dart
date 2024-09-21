import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rag_tco/navigation/app_menu.dart';
import 'package:rag_tco/misc/provider.dart';
import 'package:rag_tco/navigation/split_view.dart';
import 'package:rag_tco/pages/home.dart';
import 'package:rag_tco/pages/report.dart';
import 'package:rag_tco/pages/services.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedPageIndex = ref.watch(selectedPageIndexProvider);

    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const Material(
          child: Services(),
          // child: SplitView(
          //     // menu: const AppMenu(), content: selectedPageBuilder(context))));
          //     menu: const AppMenu(),
          //     content: IndexedStack(
          //       index: selectedPageIndex,
          //       children: [
          //         const Home(),
          //         for (var page in prePages.values) page(context),
          //         for (var page in midPages.values) page(context),
          //         for (var page in postPages.values) page(context),
          //         const Report()
          //       ],
          //     )),
        ));
  }
}
