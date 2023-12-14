import 'package:demo_chart/data/pie_chart_data.dart';
import 'package:demo_chart/screens/widgets/button_view.dart';
import 'package:demo_chart/screens/widgets/indicator_view.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PieChartPage extends StatefulWidget {
  const PieChartPage({super.key});

  @override
  State<PieChartPage> createState() => _PieChartPageState();
}

class _PieChartPageState extends State<PieChartPage> {
  late List<PieData> pieChart;

  @override
  void initState() {
    super.initState();
    pieChart = pieData;
  }

  @override
  Widget build(BuildContext context) {
    final widthDevice = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pie Chart'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: widthDevice * 0.9,
            height: widthDevice * 0.9,
            child: SfCircularChart(
              annotations: [
                CircularChartAnnotation(
                  widget: const Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Total point current',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        '30,000,000円',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Just received +100,000円',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      Text(
                        'Total point this month',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        '+1,000,000円',
                        style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      Text(
                        '+5,5%',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              series: <CircularSeries>[
                DoughnutSeries<PieData, String>(
                  // dataLabelSettings: const DataLabelSettings(isVisible:true), // show value
                  dataSource: pieChart,
                  pointColorMapper: (PieData data, _) => data.color,
                  xValueMapper: (PieData data, _) => data.x,
                  yValueMapper: (PieData data, _) => data.y,
                  innerRadius: '75%',
                  radius: '90%',
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: pieChart
                .map((e) => Indicator(
                      color: e.color,
                      text: e.x,
                      isLast: e.color == pieChart.last.color,
                    ))
                .toList(),
          ),
          ButtonView(
            title: 'Change Data',
            action: () {
              setState(
                () {
                  pieChart = newPieData;
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
