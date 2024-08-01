import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rag_tco/components/report/report_utils.dart';
import 'package:rag_tco/data_model/data_storage.dart';
import 'package:rag_tco/data_model/provider_information.dart';
import 'package:rag_tco/data_model/provider_information_notifier.dart';
import 'package:rag_tco/data_model/report_configuration.dart';
import 'package:rag_tco/data_model/report_storage.dart';
import 'package:rag_tco/data_model/report_storage_notifier.dart';
import 'package:rag_tco/misc/provider.dart';

class TotalCostBarChart extends ConsumerStatefulWidget {
  const TotalCostBarChart({super.key});

  @override
  ConsumerState<TotalCostBarChart> createState() => _TotalCostBarChartState();
}

class _TotalCostBarChartState extends ConsumerState<TotalCostBarChart> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 200,
        height: 200,
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.center,
            barTouchData: BarTouchData(
              enabled: false,
            ),
            titlesData: FlTitlesData(
              show: true,
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 28,
                  getTitlesWidget: bottomTitles,
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 40,
                  getTitlesWidget: leftTitles,
                ),
              ),
              topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
            ),
            gridData: FlGridData(
              show: true,
              checkToShowHorizontalLine: (value) => value % 10 == 0,
              getDrawingHorizontalLine: (value) => FlLine(
                color: Colors.blue.withOpacity(0.1),
                strokeWidth: 1,
              ),
              drawVerticalLine: false,
            ),
            borderData: FlBorderData(
              show: false,
            ),
            groupsSpace: 10,
            barGroups: getData(20),
          ),
        ));
  }

  List<BarChartGroupData> getData(double barsSpace) {
    ReportStorage configurationList = ref.watch(reportStorageProvider);

    List<List<BarChartRodStackItem>> stackItems = [];

    for (int i = 0; i < configurationList.reportConfigurations.length; i++) {
      stackItems
          .add(getRodStackItems(configurationList.reportConfigurations[i]));
    }
    return [
      for (int i = 0; i < stackItems.length; i++)
        BarChartGroupData(x: 0, barRods: [
          BarChartRodData(
              toY: stackItems[i][stackItems[i].length - 1].toY,
              rodStackItems: stackItems[i])
        ])
    ];
  }

  List<BarChartRodStackItem> getRodStackItems(
      ReportConfiguration configuration) {
    AsyncValue<ProviderInformation> asyncProviderInformation =
        ref.watch(providerInformationProvider);
    DataStorage dataStorage = ref.watch(dataStorageProvider);

    List<BarChartRodStackItem> returnList = [];

    switch (asyncProviderInformation) {
      case (AsyncData(:final value)):
        if (configuration.selectedService >= 0) {
          returnList.add(BarChartRodStackItem(
              0,
              ReportUtils.getAllServiceCost(value,
                  dataStorage.serviceEntries[configuration.selectedService]),
              Colors.blue));
        }
        break;
      default:
        break;
    }
    if (returnList.isEmpty) {
      returnList.add(BarChartRodStackItem(0, 0, Colors.blue));
    }
    return returnList;
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(fontSize: 10);
    String text = "N/A";
    ReportStorage reportStorage = ref.watch(reportStorageProvider);
    if (reportStorage.reportConfigurations.length > value && value >= 0) {
      text =
          reportStorage.reportConfigurations[value.floor()].configurationName;
    }
    return SideTitleWidget(
        axisSide: meta.axisSide,
        child: RotationTransition(
          turns: const AlwaysStoppedAnimation(-45 / 360),
          child: Text(text, style: style),
        ));
  }

  Widget leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      fontSize: 10,
    );
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        meta.formattedValue,
        style: style,
      ),
    );
  }
}
