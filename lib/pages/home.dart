import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rag_tco/components/toggle_item.dart';
import 'package:rag_tco/navigation/app_menu.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  void _changeHiddenPage(int pageIndex, WidgetRef ref, bool newValue) {
    //Generate new Map object, so state is updated
    Map<int, bool> oldState = ref.read(shownPagesProvider);
    Map<int, bool> newMap = Map.of(oldState);
    newMap[pageIndex] = newValue;
    ref.read(shownPagesProvider.notifier).state = newMap;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Pretransaktionskosten',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  for (var pageIndex in prePages.keys)
                    ToggleItem(
                      itemText: pageNames[pageIndex] ?? "N/A",
                      onPress: (newValue) =>
                          _changeHiddenPage(pageIndex, ref, newValue),
                    ),
                ],
              ),
              const SizedBox(
                width: 50,
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text(
                  'Transaktionskosten',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                for (var pageIndex in midPages.keys)
                  ToggleItem(
                    itemText: pageNames[pageIndex] ?? "N/A",
                    onPress: (newValue) =>
                        _changeHiddenPage(pageIndex, ref, newValue),
                  ),
                const SizedBox(
                  height: 30,
                ),
              ]),
              const SizedBox(
                width: 50,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Posttransaktionskosten',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  for (var pageIndex in postPages.keys)
                    ToggleItem(
                      itemText: pageNames[pageIndex] ?? "N/A",
                      onPress: (newValue) =>
                          _changeHiddenPage(pageIndex, ref, newValue),
                    ),
                ],
              ),
            ],
          )
        ],
      ),
    ]);
  }
}
