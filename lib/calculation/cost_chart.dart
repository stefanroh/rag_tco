import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:rag_tco/calculation/calculated_component.dart';

class CostChart extends StatefulWidget {
  const CostChart(this.components, {super.key});

  final List<CalculatedComponent> components;

  @override
  State<StatefulWidget> createState() => _CostChartState();
}

class _CostChartState extends State<CostChart> {
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
                  final rodIndex = barTouchResponse.spot!.touchedBarGroupIndex;
                  if (touchedIndex != rodIndex) {
                    setState(() {
                      touchedIndex = rodIndex;
                    });
                  }
                }
                if (event is FlTapDownEvent) {
                  // serviceCostCalculationDialog(
                  //     context, barTouchResponse.spot!.touchedBarGroupIndex);
                }
              },
              // touchTooltipData: BarTouchTooltipData(
              //     getTooltipItem: (group, groupIndex, rod, rodIndex) {
              //   return BarTooltipItem(
              //       _getTooltipString(rodIndex, widget.timeframe),
              //       const TextStyle(fontSize: 10));
              // })
            ),
            titlesData: FlTitlesData(
              show: true,
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 28,
                  getTitlesWidget: _bottomTitles,
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 40,
                  getTitlesWidget: _leftTitles,
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
            barGroups: _getData(20),
          ),
        ));
  }

  List<BarChartGroupData> _getData(double barsSpace) {
    List<List<BarChartRodStackItem>> stackItems = [];

    for (int i = 0; i < widget.components.length; i++) {
      stackItems.add(_getRodStackItems(widget.components[i]));
    }
    return [
      for (int i = 0; i < stackItems.length; i++)
        BarChartGroupData(x: i, barRods: [
          BarChartRodData(
              toY: stackItems[i][stackItems[i].length - 1].toY,
              rodStackItems: stackItems[i],
              borderSide: BorderSide(width: i == touchedIndex ? 2 : 1))
        ])
    ];
  }

  List<BarChartRodStackItem> _getRodStackItems(CalculatedComponent component) {
    List<BarChartRodStackItem> returnList = [];

    double agg = component.fixCosts;
    bool color = true;

    returnList.add(BarChartRodStackItem(0, component.fixCosts, Colors.blue));

    for (double value in component.varCosts.values) {
      color = !color;

      returnList.add(BarChartRodStackItem(
          agg, agg + value, color ? Colors.blueGrey : Colors.blue));

      agg += value;
    }
    return returnList;
  }

  Widget _bottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(fontSize: 10);
    String text = "N/A";
    if (widget.components.length > value && value >= 0) {
      text = widget.components[value.floor()].name;
    }
    return SideTitleWidget(
        axisSide: meta.axisSide,
        child: RotationTransition(
          turns: const AlwaysStoppedAnimation(-45 / 360),
          child: Text(text, style: style),
        ));
  }

  Widget _leftTitles(double value, TitleMeta meta) {
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
