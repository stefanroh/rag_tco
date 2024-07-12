import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rag_tco/components/toggle_item.dart';
import 'package:rag_tco/navigation/app_menu.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  void _changeHiddenPage(String pageName, WidgetRef ref, bool newValue) {
    //Generate new Map object, so state is updated
    Map<String, bool> oldState = ref.read(shownPagesProvider);
    Map<String, bool> newMap = Map.of(oldState);
    newMap[pageName] = newValue;
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
                  ToggleItem(
                    itemText: "Strategische Entscheidungen",
                    onPress: (newValue) => _changeHiddenPage(
                        "Strategische Entscheidungen", ref, newValue),
                  ),
                  ToggleItem(
                      itemText: "Evaluation",
                      onPress: (newValue) =>
                          _changeHiddenPage("Evaluation", ref, newValue)),
                  ToggleItem(
                      itemText: "Mitarbeiter",
                      onPress: (newValue) =>
                          _changeHiddenPage("Mitarbeiter", ref, newValue)),
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
                ToggleItem(
                    itemText: "Implementation",
                    onPress: (newValue) =>
                        _changeHiddenPage("Implementation", ref, newValue)),
                ToggleItem(
                    itemText: "Rückabwicklung",
                    onPress: (newValue) =>
                        _changeHiddenPage("Rückabwicklung", ref, newValue)),
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
                  ToggleItem(
                      itemText: "Servicegebühren",
                      onPress: (newValue) =>
                          _changeHiddenPage("Servicegebühren", ref, newValue)),
                  ToggleItem(
                      itemText: "Training",
                      onPress: (newValue) =>
                          _changeHiddenPage("Training", ref, newValue)),
                  ToggleItem(
                      itemText: "Wartung",
                      onPress: (newValue) =>
                          _changeHiddenPage("Wartung", ref, newValue)),
                  ToggleItem(
                      itemText: "Systemausfälle",
                      onPress: (newValue) =>
                          _changeHiddenPage("Systemausfälle", ref, newValue)),
                  ToggleItem(
                      itemText: "Support",
                      onPress: (newValue) =>
                          _changeHiddenPage("Support", ref, newValue))
                ],
              ),
            ],
          )
        ],
      ),
    ]);
  }
}
