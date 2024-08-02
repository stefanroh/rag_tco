
import 'package:rag_tco/data_model/cost_entry_service.dart';
import 'package:rag_tco/data_model/provider_information.dart';
import 'package:rag_tco/data_model/timeframe_type.dart';

class ReportUtils {
  static double getServiceElementCost(ProviderInformation provider,
      CostEntryService entry, TimeframeType timeframe) {
    double addedAmounts = 0;
    for (int i = 0; i < entry.getAmounts().length; i++) {
      addedAmounts +=
          (provider.serviceComponentPrices[entry.getProviderReference()][i] *
                  entry.getAmount(i) /
                  provider.serviceComponentAmounts[entry.getProviderReference()]
                      [i]) *
              entry.frequency *
              getConversionFactor(entry.referenceTimeframe, timeframe);
    }
    return addedAmounts;
  }

  static double getConversionFactor(TimeframeType from, TimeframeType to) {
    if (from == to) return 1;
    //To unit is smaller -> Factor is > 1
    if (to.index > from.index) {
      //
      if (to.index == from.index + 1) {
        if (to == TimeframeType.minute) return 60;
        if (to == TimeframeType.hour) return 60;
        if (to == TimeframeType.day) return 24;
        if (to == TimeframeType.week) return 7;
        if (to == TimeframeType.month) return 4.33333333;
        if (to == TimeframeType.year) return 12;
        return 1;
      } else {
        //Recursive Call
        return getConversionFactor(from, TimeframeType.values[from.index + 1]) *
            getConversionFactor(TimeframeType.values[from.index + 1], to);
      }
    } else {
      return 1 / getConversionFactor(to, from);
    }
  }
}
