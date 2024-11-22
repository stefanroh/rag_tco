import 'dart:developer' as dev;
import 'dart:math';

import 'package:formula_parser/formula_parser.dart';

class VariablePriceComponent {
  VariablePriceComponent(
      this.name,
      this.price,
      this.referenceAmount,
      this.onlyFullUnits,
      this.inclusiveAmount,
      this.minAmount,
      this.quantityFormular);

  String name;
  double price;
  double referenceAmount;
  bool onlyFullUnits;
  double inclusiveAmount;
  double minAmount;
  String quantityFormular;

  double calculateCost(
      String quantityFormular, Map<String, dynamic> variables) {
    dev.log(variables.toString());
    dev.log(quantityFormular);
    var formular = FormulaParser(quantityFormular, variables);
    var result = formular.parse;
    dev.log(result.toString());
    if (result["isSuccess"]) {
      double amount = result["value"];
      dev.log(amount.toString());
      amount = max(minAmount, amount);
      dev.log("Calculated Amount: ${amount.toString()}");
      double paidAmount = max(0, amount - inclusiveAmount);
      double paidUnits = paidAmount / referenceAmount;
      paidUnits = onlyFullUnits ? paidUnits.ceilToDouble() : paidUnits;

      dev.log("Cost: ${price * paidUnits}");
      return price * paidUnits;
    }
    return -1;
  }
}
