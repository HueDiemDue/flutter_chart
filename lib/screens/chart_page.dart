import 'package:demo_chart/screens/widgets/button_view.dart';
import 'package:demo_chart/utils/urls.dart';
import 'package:flutter/material.dart';

class ChartPage extends StatefulWidget {
  const ChartPage({super.key});

  @override
  State<ChartPage> createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Demo'),
      ),
      body: Center(
        child: Column(
          children: [
            ButtonView(
              title: 'Pie chart',
              action: () {
                Navigator.pushNamed(context, Urls.pieChart);
              },
            ),
            ButtonView(
              title: 'Candlestick chart',
              action: () {
                Navigator.pushNamed(context, Urls.candleStickChart);
              },
            ),
            ButtonView(
              title: 'Simulator chart',
              action: () {
                Navigator.pushNamed(context, Urls.simulatorChart);
              },
            ),
            ButtonView(
              title: 'Small chart',
              action: () {
                Navigator.pushNamed(context, Urls.smallChart);
              },
            ),
            ButtonView(
              title: 'Candle stick full chart',
              action: () {
                Navigator.pushNamed(context, Urls.candleStickFullChart);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, this.color);

  final String x;
  final double y;
  final Color color;
}
