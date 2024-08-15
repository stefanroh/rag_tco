import 'package:rag_tco/data_model/old/cost_entry_service.dart';
import 'package:rag_tco/data_model/old/provider_information.dart';
import 'package:rag_tco/data_model/old/timeframe_type.dart';

class ReportUtils {
  static double getServiceElementCost(ProviderInformation provider,
      CostEntryService entry, TimeframeType? timeframe, bool withFrequency) {
    double totalAmount = 0;
    double tempAmount = 0;
    for (int i = 0; i < entry.getAmounts().length; i++) {
      tempAmount = 0;
      tempAmount += (provider
              .serviceComponentPrices[entry.getProviderReference()][i] *
          entry.getAmount(i) /
          provider.serviceComponentAmounts[entry.getProviderReference()][i]);
      if (withFrequency) tempAmount *= entry.frequency;
      if (timeframe != null) {
        tempAmount *= getConversionFactor(entry.referenceTimeframe, timeframe);
      }
      totalAmount += tempAmount;
    }
    return totalAmount;
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
