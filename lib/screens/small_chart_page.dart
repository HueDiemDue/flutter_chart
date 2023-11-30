import 'package:demo_chart/data/pie_chart_data.dart';
import 'package:demo_chart/data/simulator_chart_data.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SmallChartPage extends StatefulWidget {
  const SmallChartPage({Key? key}) : super(key: key);

  @override
  _SmallChartPageState createState() => _SmallChartPageState();
}

class _SmallChartPageState extends State<SmallChartPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final widthDevice = MediaQuery.of(context).size.width;
    final List<double> dashArray = [5, 5];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Small Chart'),
      ),
      body: Stack(
        children: [
          Container(
            width: widthDevice,
            height: widthDevice * 2 / 3,
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
                  dataSource: [
                    SplineAreaData(1, 0, 1.5),
                    SplineAreaData(2, 0, 2),
                    SplineAreaData(3, 0, 3),
                  ],
                  xValueMapper: (SplineAreaData data, _) => data.xValue,
                  lowValueMapper: (SplineAreaData data, _) => data.lowValue,
                  highValueMapper: (SplineAreaData data, _) => data.highValue,
                  color: Colors.red.withOpacity(0.1),
                ),
                SplineSeries<SplineData, num>(
                  dataSource: [
                    SplineData(1, 1.5),
                    SplineData(2, 2),
                    SplineData(3, 3),
                  ],
                  xValueMapper: (SplineData data, _) => data.xValue,
                  yValueMapper: (SplineData data, _) => data.yValue,
                  color: Colors.red,
                ),
                SplineSeries<SplineData, num>(
                  dataSource: [
                    SplineData(0.5, 0),
                    SplineData(2, 0),
                    SplineData(3.5, 0),
                  ],
                  xValueMapper: (SplineData data, _) => data.xValue,
                  yValueMapper: (SplineData data, _) => data.yValue,
                  dashArray: dashArray,
                  color: Colors.red,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
