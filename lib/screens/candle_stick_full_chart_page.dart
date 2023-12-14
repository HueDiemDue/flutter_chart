import 'package:demo_chart/screens/widgets/candle_chart_view.dart';
import 'package:demo_chart/screens/widgets/column_chart_view.dart';
import 'package:flutter/material.dart';

final columnChartKey = GlobalKey<ColumnChartState>();
final candleChartKey = GlobalKey<CandleStickChartState>();

double maxY = 180;
double minY = 80;
double intervalX = 15;
double intervalY = 10;
String primaryXAxis = 'primaryXAxis';
String primaryYAxis = 'primaryYAxis';

double zoomPositionHorizontal = 0.5;
double zoomFactorHorizontal = 0.2;

class CandleStickFullChartPage extends StatefulWidget {
  const CandleStickFullChartPage({Key? key}) : super(key: key);

  @override
  _CandleStickFullChartPageState createState() =>
      _CandleStickFullChartPageState();
}

class _CandleStickFullChartPageState extends State<CandleStickFullChartPage> {
  late double deltaHeight = 0;

  @override
  Widget build(BuildContext context) {
    final widthDevice = MediaQuery.of(context).size.width;
    final heightDevice = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Candle Stick with Volumn Chart'),
      ),
      body: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              SizedBox(
                width: widthDevice,
                height: heightDevice * 0.55 + deltaHeight,
                child: CandleStickChart(key: candleChartKey),
              ),
              GestureDetector(
                child: Container(
                  height: 2.0,
                  margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  color: Colors.black,
                ),
                onPanUpdate: (details) {
                  final newDeltaHeight = details.delta.dy;
                  if (deltaHeight + newDeltaHeight > heightDevice * 0.1 ||
                      deltaHeight + newDeltaHeight > heightDevice * 0.8) {
                    return;
                  }
                  setState(() {
                    deltaHeight = deltaHeight + newDeltaHeight;
                  });
                },
                onPanEnd: (details) {
                  setState(() {
                    deltaHeight = 0;
                  });
                },
              ),
              SizedBox(
                width: widthDevice,
                height: heightDevice * 0.15 - deltaHeight,
                child: ColumnChart(key: columnChartKey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
