import 'package:demo_chart/data/candle_stick_data.dart';
import 'package:demo_chart/screens/widgets/ButtonView.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

double maxY = 180;
double minY = 80;

class CandleStickChartPage extends StatefulWidget {
  const CandleStickChartPage({Key? key}) : super(key: key);

  @override
  _CandleStickChartPageState createState() => _CandleStickChartPageState();
}

class _CandleStickChartPageState extends State<CandleStickChartPage> {
  late List<CandleStickData> candleSticks;
  late List<LineData> greenLineData;
  late List<LineData> blueLineData;
  late TooltipBehavior _tooltip;

  double? _currentZoomFactorX;
  double? _initialZoomFactorX;
  double? _currentZoomFactorY;
  double? _initialZoomFactorY;
  double intervalY = 10;

  @override
  void initState() {
    super.initState();
    candleSticks = candleStickData;

    greenLineData = candleStickData
        .map(
          (e) => LineData(e.x, (e.open < e.close ? e.close : e.open) + 10),
        )
        .toList();
    blueLineData = candleStickData
        .map(
          (e) => LineData(e.x, (e.high > e.low ? e.high : e.low) - 10),
        )
        .toList();
    _tooltip = TooltipBehavior(enable: true);
    intervalY = 10;
  }

  @override
  Widget build(BuildContext context) {
    final widthDevice = MediaQuery.of(context).size.width;
    final heightDevice = MediaQuery.of(context).size.height;
    final listVertical = (maxY - minY) / 10;
    const String _axisXTitle = 'AxisX';
    const String _axisYTitle = 'AxisY';
    double intervalX = 5;
    debugPrint('build ${candleSticks.length}');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Candie Stick chart'),
      ),
      body: Column(
        children: [
          SizedBox(
            width: widthDevice,
            height: heightDevice * 0.6,
            child: SfCartesianChart(
              zoomPanBehavior: ZoomPanBehavior(
                enablePanning: true,
                enablePinching: true,
                enableDoubleTapZooming: true,
              ),
              onZoomStart: (args) {
                if (_currentZoomFactorX == null &&
                    args.axis?.title.text == _axisXTitle) {
                  _currentZoomFactorX = args.currentZoomFactor;
                }
                if (_currentZoomFactorY == null &&
                    args.axis?.title.text == _axisYTitle) {
                  _currentZoomFactorY = args.currentZoomFactor;
                }
                if (_initialZoomFactorX == null &&
                    args.axis?.title.text == _axisXTitle) {
                  _initialZoomFactorX = args.currentZoomFactor;
                }
                if (_initialZoomFactorY == null &&
                    args.axis?.title.text == _axisYTitle) {
                  _initialZoomFactorY = args.currentZoomFactor;
                }
              },
              onZooming: (args) {
                if (args.currentZoomFactor.isNaN ||
                    args.currentZoomFactor.isInfinite) return;
                if (args.axis?.title.text == _axisXTitle) {
                  _currentZoomFactorX = args.currentZoomFactor;
                }
                if (args.axis?.title.text == _axisYTitle) {
                  _currentZoomFactorY = args.currentZoomFactor;
                }
              },
              primaryXAxis: CategoryAxis(
                visibleMaximum: (4 * intervalX) - 1,
                visibleMinimum: 0,
                interval: intervalX,
                axisLabelFormatter: (AxisLabelRenderDetails details) {
                  final index = details.value.toInt();
                  debugPrint('axisLabelFormatter $index===${details.text}');

                  bool isZooming = false;
                  bool isZoomingX = false;
                  bool isZoomingY = false;
                  if (_currentZoomFactorX != null &&
                      _initialZoomFactorX != null) {
                    isZoomingX = _currentZoomFactorX! > _initialZoomFactorX!;
                  }
                  if (_currentZoomFactorY != null &&
                      _initialZoomFactorY != null) {
                    isZoomingY = _currentZoomFactorY! > _initialZoomFactorY!;
                  }
                  isZooming = isZoomingX || isZoomingY;

                  return ChartAxisLabel(
                    details.text,
                    const TextStyle(
                      color: Colors.black,
                      // fontSize: 13.0,
                    ),
                  );
                },
              ),
              primaryYAxis: NumericAxis(
                minimum: minY,
                maximum: maxY,
                interval: intervalY,
                enableAutoIntervalOnZooming: false,
                plotBands: [
                  ...List.generate(listVertical.toInt(), (index) {
                    if (index % 2 == 0) {
                      return PlotBand(isVisible: false);
                    }
                    final start = 80 + index * intervalY;

                    return PlotBand(
                      shouldRenderAboveSeries: false,
                      start: start,
                      end: start + intervalY,
                      color: Colors.grey,
                      opacity: 0.1,
                    );
                  }),
                ],
              ),
              enableAxisAnimation: true,
              tooltipBehavior: _tooltip,
              series: <ChartSeries>[
                CandleSeries<CandleStickData, String>(
                  dataSource: candleSticks,
                  xValueMapper: (CandleStickData data, _) =>
                      DateFormat('dd/MM').format(data.x),
                  highValueMapper: (CandleStickData data, _) => data.high,
                  bullColor: Colors.blue,
                  lowValueMapper: (CandleStickData data, _) => data.low,
                  openValueMapper: (CandleStickData data, _) => data.open,
                  closeValueMapper: (CandleStickData data, _) => data.close,
                ),
                LineSeries<LineData, String>(
                  dataSource: greenLineData,
                  xValueMapper: (LineData data, _) =>
                      DateFormat('dd/MM').format(data.x),
                  yValueMapper: (LineData data, _) => data.y,
                  color: Colors.green,
                ),
                LineSeries<LineData, String>(
                  dataSource: blueLineData,
                  xValueMapper: (LineData data, _) =>
                      DateFormat('dd/MM').format(data.x),
                  yValueMapper: (LineData data, _) => data.y,
                  color: Colors.blueAccent,
                ),
              ],
            ),
          ),
          ButtonView(
            title: 'Change Data',
            action: () {
              setState(() {
                candleSticks = newCandleStickData;
                greenLineData = newCandleStickData
                    .map((e) => LineData(
                        e.x, (e.open < e.close ? e.close : e.open) + 10))
                    .toList();
                blueLineData = newCandleStickData
                    .map((e) =>
                        LineData(e.x, (e.high > e.low ? e.high : e.low) - 10))
                    .toList();
              });
            },
          ),
        ],
      ),
    );
  }
}
