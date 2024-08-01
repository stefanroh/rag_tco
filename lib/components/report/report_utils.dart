import 'package:rag_tco/data_model/cost_entry.dart';
import 'package:rag_tco/data_model/cost_entry_service.dart';
import 'package:rag_tco/data_model/provider_information.dart';

class ReportUtils {
  static double getAllServiceCost(
      ProviderInformation provider, CostEntryService entry) {
    double addedAmounts = 0;
    for (int i = 0; i < entry.getAmounts().length; i++) {
      addedAmounts +=
          provider.serviceComponentPrices[entry.getProviderReference()][i] *
              entry.getAmount(i) /
              provider.serviceComponentAmounts[entry.getProviderReference()][i];
    }
    return addedAmounts;
  }
}
