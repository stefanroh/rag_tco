import 'package:flutter/material.dart';
import 'package:rag_tco/components/button.dart';
import 'package:rag_tco/components/service/new/architecture_component/architecture_selector.dart';
import 'package:rag_tco/components/service/new/use_case/use_case_formular_dialog.dart';
import 'package:rag_tco/data_model/new/architecture_component.dart';
import 'package:rag_tco/data_model/new/use_case_storage.dart';
import 'package:rag_tco/misc/provider_selector.dart';
import 'package:rag_tco/misc/type_selector.dart';

class UseCaseComponents extends StatefulWidget {
  UseCaseComponents(
      {super.key, required this.storage, required this.components});

  final UseCaseStorage storage;
  final List<ArchitectureComponent> components;
  final List<TextEditingController> controllerList = [];

  @override
  State<UseCaseComponents> createState() => _UseCaseComponentsState();
}

class _UseCaseComponentsState extends State<UseCaseComponents> {
  ArchitectureComponent? selectedComponent;
  String? selectedProvider;
  String? selectedType;

  @override
  Widget build(BuildContext context) {
    if (selectedComponent != null) {
      if (selectedProvider != null &&
          selectedComponent!.provider != selectedProvider) {
        selectedComponent = null;
      } else if (selectedType != null &&
          selectedComponent!.type != selectedType) {
        selectedComponent = null;
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 3),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 1),
                child: ProviderSelector(
                    250,
                    selectedProvider,
                    (val) => setState(() {
                          selectedProvider = val;
                        }),
                    widget.components),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 1),
                child: TypeSelector(
                    250,
                    selectedType,
                    (val) => setState(() {
                          selectedType = val;
                        }),
                    widget.components),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 1),
                child: ArchitectureSelector(
                    onSelected: (val) => selectedComponent = val,
                    width: 250,
                    initialSelection: selectedComponent,
                    components: widget.components,
                    filterProvider: selectedProvider,
                    filterType: selectedType),
              ),
              Button(
                  text: 'Add',
                  onPressed: () {
                    setState(() {
                      if (selectedComponent != null) {
                        List<String> quantityFormulars = selectedComponent!
                            .variablePriceComponents
                            .map((element) => element.quantityFormular)
                            .toList();
                        widget.storage.addComponent(
                            selectedComponent!, quantityFormulars);
                      }
                    });
                  }),
            ],
          ),
        ),
        SizedBox(
          height: 200,
          width: 450,
          child: SingleChildScrollView(
            child: Column(
              children: [
                for (int i = 0; i < widget.storage.getComponentCount(); i++)
                  getRow(i),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget getRow(int i) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: SizedBox(
              width: 250,
              child: Text(widget.storage.components[i].componentName),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Button(
                text: "Edit Formulars",
                onPressed: () => _formularEditDialog(context, i)),
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Button(
                text: 'Delete',
                onPressed: () {
                  setState(() {
                    widget.storage.removeComponent(i);
                  });
                }),
          ),
        ],
      ),
    );
  }

  Future<void> _formularEditDialog(
      BuildContext context, int useCaseComponentIndex) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return UseCaseFormularDialog(
            context,
            storage: widget.storage,
            useCaseComponentIndex: useCaseComponentIndex,
          );
        });
  }
}
