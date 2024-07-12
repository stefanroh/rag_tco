import 'package:flutter/material.dart';

class PageListTile extends StatelessWidget {
  const PageListTile({
    super.key,
    this.selectedPageName,
    required this.pageName,
    this.onPressed,
  });
  final String? selectedPageName;
  final String pageName;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: ListTile(
            contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
            title: Text(pageName),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            onTap: onPressed,
            tileColor: selectedPageName == pageName
                ? const Color.fromRGBO(220, 220, 220, 0.7)
                : null));
  }
}
