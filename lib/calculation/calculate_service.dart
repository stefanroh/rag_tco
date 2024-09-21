import 'package:flutter/material.dart';
import 'package:rag_tco/calculation/calculated_component.dart';
import 'package:rag_tco/calculation/cost_chart.dart';
import 'package:rag_tco/data_model/new/use_case_storage.dart';

class CalculateService {
  CalculateService(this.storage, this.variables);

  UseCaseStorage storage;
  Map<String, dynamic> variables;

  List<CalculatedComponent> calculatedComponents = [];

  void calculateCost() {
    calculatedComponents = [];
    for (int i = 0; i < storage.getComponentCount(); i++) {
      calculatedComponents.add(storage.components[i]
          .calculateVariableCost(storage.quantityFormulars[i], variables));
    }
  }

  Widget getCostTable() {
    List<TableRow> rows = [];
    // rows.add(const TableRow(children: [
    //   TableCell(
    //       child: Padding(
    //     padding: EdgeInsets.all(8),
    //     child: Text("Architecture Component"),
    //   )),
    //   TableCell(
    //       child: Padding(
    //     padding: EdgeInsets.all(8),
    //     child: Text("Price Component"),
    //   )),
    //   TableCell(
    //       child: Padding(
    //     padding: EdgeInsets.all(8),
    //     child: Text("Price"),
    //   ))
    // ]));
    for (CalculatedComponent comp in calculatedComponents) {
      rows.addAll(_getTableRow(comp));
    }

    return Table(
      children: rows,
    );
  }

  Widget getCostChart() {
    return CostChart(calculatedComponents);
  }

  List<TableRow> _getTableRow(CalculatedComponent component) {
    List<TableRow> returnList = [];
    returnList.add(TableRow(children: [
      TableCell(
          child: Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          component.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      )),
      const TableCell(
          child: Padding(
        padding: EdgeInsets.all(8),
        child: Text("Total", style: TextStyle(fontWeight: FontWeight.bold)),
      )),
      TableCell(
          child: Padding(
        padding: const EdgeInsets.all(8),
        child: Text(component.getTotalCost().toStringAsFixed(2),
            style: const TextStyle(fontWeight: FontWeight.bold)),
      ))
    ]));
    returnList.add(TableRow(children: [
      const TableCell(
          child: Padding(
        padding: EdgeInsets.all(8),
        child: Text(""),
      )),
      const TableCell(
          child: Padding(
        padding: EdgeInsets.all(8),
        child: Text("Fix Cost"),
      )),
      TableCell(
          child: Padding(
              padding: const EdgeInsets.all(8),
              child: Text(component.fixCosts.toStringAsFixed(2))))
    ]));
    for (String key in component.varCosts.keys) {
      returnList.add(TableRow(children: [
        const TableCell(
            child: Padding(
          padding: EdgeInsets.all(8),
          child: Text(""),
        )),
        TableCell(
            child: Padding(
          padding: const EdgeInsets.all(8),
          child: Text(key),
        )),
        TableCell(
            child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text(component.varCosts[key]!.toStringAsFixed(2))))
      ]));
    }
    return returnList;
  }
}
