class CalculatedComponent {
  CalculatedComponent(this.name);

  String name;
  double fixCosts = 0;
  Map<String, double> varCosts = <String, double>{};

  void addVarCost(String elementName, double value) {
    double existingValue = varCosts[elementName] ?? 0;
    varCosts[elementName] = existingValue + value;
  }

  double getVarCosts() {
    double totalVarCosts = 0;
    for (double c in varCosts.values) {
      totalVarCosts += c;
    }
    return totalVarCosts;
  }

  double getFixCost() {
    return fixCosts;
  }

  double getTotalCost() {
    return fixCosts + getVarCosts();
  }
}
