import 'package:flutter/material.dart';
import 'package:rag_tco/navigation/app_menu.dart';

class MenuEntry extends StatelessWidget {
  const MenuEntry({
    super.key,
    this.selectedPageIndex,
    required this.pageIndex,
    this.onPressed,
  });
  final int? selectedPageIndex;
  final int pageIndex;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: ListTile(
            contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
            title: Text(pageNames[pageIndex] ?? "N/A"),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            onTap: onPressed,
            tileColor: selectedPageIndex == pageIndex
                ? const Color.fromRGBO(220, 220, 220, 0.7)
                : null));
  }
}
