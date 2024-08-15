import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rag_tco/components/report/report_utils.dart';
import 'package:rag_tco/components/report/service_cost_calculation_dialog.dart';
import 'package:rag_tco/data_model/old/data_storage.dart';
import 'package:rag_tco/data_model/old/provider_information.dart';
import 'package:rag_tco/data_model/old/report_configuration.dart';
import 'package:rag_tco/data_model/old/report_storage.dart';
import 'package:rag_tco/data_model/old/timeframe_type.dart';
import 'package:rag_tco/misc/provider.dart';

class ServiceCostBarChart extends ConsumerStatefulWidget {
  const ServiceCostBarChart({required this.timeframe, super.key});

  final TimeframeType timeframe;

  @override
  ConsumerState<ServiceCostBarChart> createState() =>
      _ServiceCostBarChartState();
}

class _ServiceCostBarChartState extends ConsumerState<ServiceCostBarChart> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 600,
        height: 400,
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.center,
            barTouchData: BarTouchData(
                enabled: true,
                touchCallback: (FlTouchEvent event, barTouchResponse) {
                  if (!event.isInterestedForInteractions ||
                      barTouchResponse == null ||
                      barTouchResponse.spot == null) {
                    if (touchedIndex != -1) {
                      setState(() {
                        touchedIndex = -1;
                      });
                    }
                    return;
                  }
                  if (event is FlPointerHoverEvent) {
                    final rodIndex =
                        barTouchResponse.spot!.touchedBarGroupIndex;
                    if (touchedIndex != rodIndex) {
                      setState(() {
                        touchedIndex = rodIndex;
                      });
                    }
                  }
                  if (event is FlTapDownEvent) {
                    serviceCostCalculationDialog(
                        context, barTouchResponse.spot!.touchedBarGroupIndex);
                  }
                },
                touchTooltipData: BarTouchTooltipData(
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                  return BarTooltipItem(
                      getTooltipString(rodIndex, widget.timeframe),
                      const TextStyle(fontSize: 10));
                })),
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
              rodStackItems: stackItems[i],
              borderSide: BorderSide(width: i == touchedIndex ? 2 : 1))
        ])
    ];
  }

  String getTooltipString(int configIndex, TimeframeType timeframe) {
    DataStorage dataStorage = ref.read(dataStorageProvider);
    ReportStorage reportStorage = ref.read(reportStorageProvider);
    AsyncValue<ProviderInformation> providerInformation =
        ref.read(providerInformationProvider);
    String returnString = "";

    switch (providerInformation) {
      case (AsyncData(:final value)):
        for (int i = 0;
            i <
                reportStorage
                    .reportConfigurations[configIndex].selectedService.length;
            i++) {
          returnString +=
              "${dataStorage.serviceEntries[reportStorage.reportConfigurations[configIndex].selectedService[i]].entryName}: ${ReportUtils.getServiceElementCost(value, dataStorage.serviceEntries[reportStorage.reportConfigurations[configIndex].selectedService[i]], timeframe, true)}";
          if (i !=
              reportStorage.reportConfigurations[configIndex].selectedService
                  .length) returnString += "\n";
        }
        return returnString;
      default:
        return "";
    }
  }

  List<BarChartRodStackItem> getRodStackItems(
      ReportConfiguration configuration) {
    AsyncValue<ProviderInformation> asyncProviderInformation =
        ref.watch(providerInformationProvider);
    DataStorage dataStorage = ref.watch(dataStorageProvider);

    List<BarChartRodStackItem> returnList = [];

    switch (asyncProviderInformation) {
      case (AsyncData(:final value)):
        if (configuration.selectedService.isNotEmpty) {
          double agg = 0;
          bool color = true;
          for (int entry in configuration.selectedService) {
            double entryCost = ReportUtils.getServiceElementCost(value,
                dataStorage.serviceEntries[entry], widget.timeframe, true);
            color = !color;

            returnList.add(BarChartRodStackItem(
                agg, agg + entryCost, color ? Colors.blue : Colors.red));

            agg += entryCost;
          }
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

  Future<void> serviceCostCalculationDialog(
      BuildContext context, int configIndex) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return ServiceCostCalculationDialog(
            timeframe: widget.timeframe,
            configIndex: configIndex,
          );
        });
  }
}
