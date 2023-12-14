import 'dart:ffi';

import 'package:demo_chart/data/candle_stick_data.dart';
import 'package:demo_chart/screens/candle_stick_full_chart_page.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class CandleStickChart extends StatefulWidget {
  const CandleStickChart({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CandleStickChartState();
  }
}

class CandleStickChartState extends State<CandleStickChart> {
  CandleStickChartState({Key? key});

  late ZoomPanBehavior _zoomPanBehavior;
  late TooltipBehavior _tooltipBehavior;

  late List<CandleStickData> candleSticks;
  late List<LineData> greenLineData;
  late List<LineData> blueLineData;
  late List<SplineAreaData> splinesRed;
  late List<SplineAreaData> splinesBlue;
  late CrosshairBehavior _crossHairBehavior;

  late double minYCandle;

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
    candleSticks = candleStickData;
    minYCandle = minY;

    greenLineData = candleStickData
        .map(
          (e) => LineData(e.x, e.open + 50),
        )
        .toList();
    blueLineData = candleStickData
        .map(
          (e) => LineData(e.x, (e.high > e.low ? e.high : e.low) - 10),
        )
        .toList();
    final splines = candleStickData
        .map((e) => SplineAreaData(
              e.x,
              e.low + 10,
              e.high + 20,
            ))
        .toList();
    final numberTruncate = (splines.length / 2).round();
    splinesRed = splines.sublist(0, numberTruncate);
    splinesBlue = splines.sublist(numberTruncate - 1, splines.length);

    _crossHairBehavior = CrosshairBehavior(
      enable: true,
      activationMode: ActivationMode.singleTap,
      lineDashArray: [5, 5],
      lineColor: Colors.grey,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final widthDevice = MediaQuery.of(context).size.width;

    return SfCartesianChart(
      crosshairBehavior: _crossHairBehavior,
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      zoomPanBehavior: _zoomPanBehavior,
      onZooming: (ZoomPanArgs args) {
        if (args.axis!.name == primaryXAxis) {
          zoomPositionHorizontal = args.currentZoomPosition;
          zoomFactorHorizontal = args.currentZoomFactor;
          columnChartKey.currentState!.refreshChart();
        }
      },
      onActualRangeChanged: (ActualRangeChangedArgs args) {
        if (args.orientation == AxisOrientation.vertical) {
          minYCandle = args.visibleMin;
        }
        if (args.orientation == AxisOrientation.horizontal) {
          final visibleMax = args.visibleMax;
          final distanceX = visibleMax - args.visibleMin;
          debugPrint(
              'onActualRangeChanged ${args.visibleMax} === ${args.visibleMin}===$distanceX');
          if (distanceX <= 10) {
            intervalX = 2;
          } else if (distanceX <= 15) {
            intervalX = 5;
          } else {
            intervalX = 15;
          }
        }
      },
      primaryXAxis: CategoryAxis(
        name: primaryXAxis,
        isVisible: false,
        zoomFactor: zoomFactorHorizontal,
        zoomPosition: zoomPositionHorizontal,
        // visibleMaximum: (4 * intervalX) - 1,
        // visibleMinimum: 0,
        interval: intervalX,
      ),
      primaryYAxis: NumericAxis(
        name: primaryYAxis,
        labelsExtent: widthDevice * 0.1,
        opposedPosition: true,
        minimum: minY,
        maximum: maxY,
        interval: intervalY,
        enableAutoIntervalOnZooming: false,
        axisLabelFormatter: (AxisLabelRenderDetails details) {
          return ChartAxisLabel(
            details.value == minYCandle ? '' : details.text,
            const TextStyle(
              color: Colors.black,
              // fontSize: 13.0,
            ),
          );
        },
      ),
      enableAxisAnimation: true,
      tooltipBehavior: _tooltipBehavior,
      series: <ChartSeries>[
        CandleSeries<CandleStickData, String>(
          dataSource: candleSticks,
          xValueMapper: (CandleStickData data, _) =>
              DateFormat('dd/MM/yyyy HH:mm').format(data.x),
          highValueMapper: (CandleStickData data, _) => data.high,
          bullColor: Colors.blue,
          lowValueMapper: (CandleStickData data, _) => data.low,
          openValueMapper: (CandleStickData data, _) => data.open,
          closeValueMapper: (CandleStickData data, _) => data.close,
          enableSolidCandles: true,
        ),
        SplineRangeAreaSeries<SplineAreaData, String>(
          dataSource: splinesRed,
          xValueMapper: (SplineAreaData data, _) =>
              DateFormat('dd/MM/yyyy HH:mm').format(data.xValue),
          lowValueMapper: (SplineAreaData data, _) => data.lowValue,
          highValueMapper: (SplineAreaData data, _) => data.highValue,
          color: Colors.red.withOpacity(0.5),
        ),
        SplineRangeAreaSeries<SplineAreaData, String>(
          dataSource: splinesBlue,
          xValueMapper: (SplineAreaData data, _) =>
              DateFormat('dd/MM/yyyy HH:mm').format(data.xValue),
          lowValueMapper: (SplineAreaData data, _) => data.lowValue,
          highValueMapper: (SplineAreaData data, _) => data.highValue,
          color: Colors.blueAccent.withOpacity(0.5),
        ),
        LineSeries<LineData, String>(
          dataSource: greenLineData,
          xValueMapper: (LineData data, _) =>
              DateFormat('dd/MM/yyyy HH:mm').format(data.x),
          yValueMapper: (LineData data, _) => data.y,
          color: Colors.green,
        ),
        LineSeries<LineData, String>(
          dataSource: blueLineData,
          xValueMapper: (LineData data, _) =>
              DateFormat('dd/MM/yyyy HH:mm').format(data.x),
          yValueMapper: (LineData data, _) => data.y,
          color: Colors.purple,
        ),
      ],
    );
  }
}
