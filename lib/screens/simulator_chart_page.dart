import 'package:demo_chart/data/simulator_chart_data.dart';
import 'package:demo_chart/screens/widgets/button_view.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SimulatorChartPage extends StatefulWidget {
  const SimulatorChartPage({Key? key}) : super(key: key);

  @override
  _SimulatorChartPageState createState() => _SimulatorChartPageState();
}

class _SimulatorChartPageState extends State<SimulatorChartPage> {
  late List<SplineAreaData> splinesArea;
  late List<SplineAreaData> splinesAreaLower;
  late List<SplineData> splines;
  late List<SplineData> splinesLower;

  @override
  void initState() {
    super.initState();
    splinesArea = splineArea;
    splinesAreaLower = splineAreaLower;
    splines = splineData;
    splinesLower = splineDataLower;
  }

  @override
  Widget build(BuildContext context) {
    final widthDevice = MediaQuery.of(context).size.width;
    final List<double> dashArray = [5, 5];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Simulator Chart'),
      ),
      body: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                width: widthDevice,
                height: widthDevice * 2 / 3,
                child: SfCartesianChart(
                  zoomPanBehavior: ZoomPanBehavior(
                    enablePanning: true,
                    enablePinching: true,
                  ),
                  primaryXAxis: NumericAxis(
                    labelStyle: TextStyle(color: Colors.black.withOpacity(0.0)),
                    axisLine: AxisLine(
                      width: 1.0,
                      dashArray: dashArray,
                      color: Colors.black.withOpacity(0.2),
                    ),
                    minimum: 0,
                    visibleMaximum: 2,
                    visibleMinimum: 0,
                  ),
                  primaryYAxis: NumericAxis(
                    isVisible: true,
                    minimum: 0,
                    maximum: 4,
                    interval: 2,
                    axisLine: const AxisLine(width: 0),
                    majorGridLines: MajorGridLines(
                      width: 1.0,
                      dashArray: dashArray,
                      color: Colors.black.withOpacity(0.2),
                    ),
                    minorGridLines: MinorGridLines(
                      width: 1.0,
                      dashArray: dashArray,
                      color: Colors.black.withOpacity(0.2),
                    ),
                    tickPosition: TickPosition.inside,
                    labelStyle: TextStyle(color: Colors.black.withOpacity(0.0)),
                  ),
                  series: <CartesianSeries>[
                    SplineRangeAreaSeries<SplineAreaData, num>(
                      dataSource: splinesArea,
                      xValueMapper: (SplineAreaData data, _) => data.xValue,
                      lowValueMapper: (SplineAreaData data, _) => data.lowValue,
                      highValueMapper: (SplineAreaData data, _) =>
                          data.highValue,
                      color: Colors.grey.withOpacity(0.2),
                    ),
                    SplineRangeAreaSeries<SplineAreaData, num>(
                      dataSource: splinesAreaLower,
                      xValueMapper: (SplineAreaData data, _) => data.xValue,
                      lowValueMapper: (SplineAreaData data, _) => data.lowValue,
                      highValueMapper: (SplineAreaData data, _) =>
                          data.highValue,
                      color: Colors.grey.withOpacity(0.2),
                    ),
                    SplineSeries<SplineData, num>(
                      dataSource: splines,
                      xValueMapper: (SplineData data, _) => data.xValue,
                      yValueMapper: (SplineData data, _) => data.yValue,
                      color: Colors.red,
                    ),
                    SplineSeries<SplineData, num>(
                      dataSource: splinesLower,
                      xValueMapper: (SplineData data, _) => data.xValue,
                      yValueMapper: (SplineData data, _) => data.yValue,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              Positioned(
                top: widthDevice * 2 / 3 / 3 - 10,
                left: 25,
                child: const Column(
                  children: [
                    Text(
                      'Simulator Chart',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '3000 Point',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          ButtonView(
            title: 'Change Data',
            action: () {
              setState(
                () {
                  splines = newSplineData;
                  splinesLower = newSplineDataLower;
                  splinesArea = newSplineArea;
                  splinesAreaLower = newSplineAreaLower;
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
