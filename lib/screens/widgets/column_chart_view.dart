import 'package:demo_chart/data/candle_stick_data.dart';
import 'package:demo_chart/screens/candle_stick_full_chart_page.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class ColumnChart extends StatefulWidget {
  const ColumnChart({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ColumnChartState();
  }
}

class ColumnChartState extends State<ColumnChart> {
  ColumnChartState({Key? key});

  late ZoomPanBehavior _zoomPanBehavior;
  late TooltipBehavior _tooltipBehavior;
  late List<ColumnData> columnData;
  late CrosshairBehavior _crossHairBehavior;
  late List<SplineAreaData> splines;

  void refreshChart() {
    setState(() {});
  }

  @override
  void initState() {
    _zoomPanBehavior = ZoomPanBehavior(
      enablePanning: true,
      enablePinching: true,
      enableDoubleTapZooming: true,
      zoomMode: ZoomMode.xy,
      enableMouseWheelZooming: true,
    );
    _tooltipBehavior = TooltipBehavior(enable: true);
    columnData = candleStickData
        .map(
          (e) => ColumnData(
            e.x,
            (e.high > e.low ? e.high : e.low) - 10,
            e.open > e.close ? 0 : 1,
          ),
        )
        .toList();
    _crossHairBehavior = CrosshairBehavior(
      enable: true,
      activationMode: ActivationMode.singleTap,
      lineDashArray: [5, 5],
      lineColor: Colors.grey,
    );
    splines = candleStickData
        .map(
          (e) => SplineAreaData(e.x, e.low, e.low - 20),
        )
        .toList();
    debugPrint('columnData ${columnData[1].x}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final widthDevice = MediaQuery.of(context).size.width;

    return SfCartesianChart(
      crosshairBehavior: _crossHairBehavior,
      onZooming: (ZoomPanArgs args) {
        if (args.axis!.name == primaryXAxis) {
          zoomPositionHorizontal = args.currentZoomPosition;
          zoomFactorHorizontal = args.currentZoomFactor;
          candleChartKey.currentState!.refreshChart();
        }
      },
      onActualRangeChanged: (ActualRangeChangedArgs args) {
        if (args.orientation == AxisOrientation.horizontal) {
          final visibleMax = args.visibleMax;
          final distanceX = visibleMax - args.visibleMin;
          if (distanceX <= 10) {
            intervalX = 2;
          } else if (distanceX <= 15) {
            intervalX = 5;
          } else {
            intervalX = 15;
          }
        }
      },
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      zoomPanBehavior: _zoomPanBehavior,
      primaryXAxis: CategoryAxis(
        name: primaryXAxis,
        // visibleMaximum: (4 * intervalX) - 1,
        // visibleMinimum: 0,
        interval: intervalX,
        axisLabelFormatter: (AxisLabelRenderDetails details) {
          final currentDate =
              DateFormat("dd/MM/yyyy HH:mm").parse(details.text);
          var textDisplay = details.text;
          if (currentDate.hour != 0 && intervalX < 5) {
            textDisplay = '${currentDate.hour}:00';
          } else if (currentDate.compareTo(DateTime(
                currentDate.year,
                currentDate.month,
                1,
              )) ==
              0) {
            final nameMonth = DateFormat.MMMM().format(currentDate);
            textDisplay = nameMonth[0] + nameMonth[1] + nameMonth[2];
          } else {
            textDisplay = DateFormat('dd/MM').format(currentDate);
          }
          return ChartAxisLabel(
            textDisplay,
            const TextStyle(
              color: Colors.black,
            ),
          );
        },
        zoomFactor: zoomFactorHorizontal,
        zoomPosition: zoomPositionHorizontal,
        // majorTickLines: const MajorTickLines(width: 0),
        majorGridLines: const MajorGridLines(
          width: 0.5,
          color: Colors.transparent,
        ),
      ),
      primaryYAxis: NumericAxis(
        name: primaryYAxis,
        labelsExtent: widthDevice * 0.1,
        opposedPosition: true,
        minimum: minY,
        maximum: minY + intervalY * 2,
        interval: intervalY,
        enableAutoIntervalOnZooming: false,
        axisLabelFormatter: (AxisLabelRenderDetails details) {
          return ChartAxisLabel(
            details.value == (minY + intervalY * 2) ? '' : details.text,
            const TextStyle(
              color: Colors.black,
            ),
          );
        },
      ),
      enableAxisAnimation: true,
      tooltipBehavior: _tooltipBehavior,
      series: <ChartSeries>[
        ColumnSeries<ColumnData, String>(
          dataSource: columnData,
          xValueMapper: (ColumnData data, _) =>
              DateFormat('dd/MM/yyyy HH:mm').format(data.x),
          yValueMapper: (ColumnData data, _) =>
              (data.y - 5) > 100 ? 5 : data.y - 5,
          spacing: 0.05,
          width: 1,
          pointColorMapper: (ColumnData data, _) =>
              data.color == 0 ? Colors.red : Colors.blueAccent,
        ),
      ],
    );
  }
}
