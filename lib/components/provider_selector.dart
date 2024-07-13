import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rag_tco/data_model/provider_information.dart';
import 'package:rag_tco/misc/provider.dart';

@immutable
class ProviderSelector extends ConsumerWidget {
  const ProviderSelector({super.key, required this.onSelect});

  final void Function(int) onSelect;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<ProviderInformation> asyncProviderInformation =
        ref.watch(providerInformationProvider);

    return switch (asyncProviderInformation) {
      AsyncData(:final value) => DropdownMenu(
            initialSelection: 0,
            onSelected: (value) => onSelect(value ?? 0),
            dropdownMenuEntries: [
              for (var i = 0; i < value.serviceName.length; i++)
                DropdownMenuEntry(value: i, label: value.serviceName[i])
            ]),
      AsyncError(:final error) => Text('Error: $error'),
      _ => const Center(child: CircularProgressIndicator()),
    };
  }
}
