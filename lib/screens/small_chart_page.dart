import 'package:demo_chart/data/pie_chart_data.dart';
import 'package:demo_chart/data/simulator_chart_data.dart';
import 'package:demo_chart/data/small_chart_data.dart';
import 'package:demo_chart/screens/widgets/button_view.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SmallChartPage extends StatefulWidget {
  const SmallChartPage({Key? key}) : super(key: key);

  @override
  _SmallChartPageState createState() => _SmallChartPageState();
}

class _SmallChartPageState extends State<SmallChartPage> {
  late bool changeNew;
  late List<SplineData> splineData;
  late List<SplineAreaData> splineAreaData;
  late List<SplineData> lines;
  late List<SplineAreaData> linesAreaData;

  @override
  void initState() {
    super.initState();
    changeNew = false;
    splineData = splines;
    splineAreaData =
        splines.map((e) => SplineAreaData(e.xValue, 0, e.yValue)).toList();
    lines = splinesOverLimit;
    linesAreaData = splinesOverLimit
        .map((e) => SplineAreaData(e.xValue, 0, e.yValue))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final widthDevice = MediaQuery.of(context).size.width;
    final List<double> dashArray = [6, 6];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Small Chart'),
      ),
      body: Column(
        children: [
          SizedBox(
            width: widthDevice / 2,
            height: widthDevice * 2 / 3 / 2,
            child: SfCartesianChart(
              plotAreaBorderWidth: 0,
              primaryXAxis: NumericAxis(
                minimum: 0,
                isVisible: false,
              ),
              primaryYAxis: NumericAxis(
                minimum: 0,
                maximum: 4,
                isVisible: false,
              ),
              series: <CartesianSeries>[
                SplineRangeAreaSeries<SplineAreaData, num>(
                  dataSource: splineAreaData,
                  xValueMapper: (SplineAreaData data, _) => data.xValue,
                  lowValueMapper: (SplineAreaData data, _) => data.lowValue,
                  highValueMapper: (SplineAreaData data, _) => data.highValue,
                  color: Colors.red.withOpacity(0.1),
                ),
                SplineSeries<SplineData, num>(
                  dataSource: splineData,
                  xValueMapper: (SplineData data, _) => data.xValue,
                  yValueMapper: (SplineData data, _) => data.yValue,
                  color: Colors.red,
                ),
                SplineSeries<SplineData, num>(
                  dataSource: standardY,
                  xValueMapper: (SplineData data, _) => data.xValue,
                  yValueMapper: (SplineData data, _) => data.yValue,
                  dashArray: dashArray,
                  color: Colors.red,
                  width: 3,
                ),
              ],
            ),
          ),
          SizedBox(
            width: widthDevice / 2,
            height: widthDevice * 2 / 3 / 2,
            child: SfCartesianChart(
              plotAreaBorderWidth: 0,
              primaryXAxis: NumericAxis(
                minimum: 0,
                isVisible: false,
              ),
              primaryYAxis: NumericAxis(
                minimum: 0,
                maximum: 4,
                isVisible: false,
              ),
              series: <CartesianSeries>[
                RangeAreaSeries<SplineAreaData, num>(
                  dataSource: linesAreaData,
                  xValueMapper: (SplineAreaData data, _) => data.xValue,
                  lowValueMapper: (SplineAreaData data, _) => data.lowValue,
                  highValueMapper: (SplineAreaData data, _) => data.highValue,
                  color: Colors.red.withOpacity(0.1),
                ),
                LineSeries<SplineData, num>(
                  dataSource: lines,
                  xValueMapper: (SplineData data, _) => data.xValue,
                  yValueMapper: (SplineData data, _) => data.yValue,
                  color: Colors.red,
                ),
                SplineSeries<SplineData, num>(
                  dataSource: standardLimit,
                  xValueMapper: (SplineData data, _) => data.xValue,
                  yValueMapper: (SplineData data, _) => data.yValue,
                  dashArray: dashArray,
                  color: Colors.red,
                ),
              ],
            ),
          ),
          ButtonView(
            title: 'Change Data',
            action: () {
              setState(
                () {
                  splineData = newSplines;
                  splineAreaData = newSplines
                      .map((e) => SplineAreaData(e.xValue, 0, e.yValue))
                      .toList();
                  lines = newSplinesOverLimit;
                  linesAreaData = newSplinesOverLimit
                      .map((e) => SplineAreaData(e.xValue, 0, e.yValue))
                      .toList();
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
