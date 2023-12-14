import 'package:demo_chart/screens/candle_stick_chart_page.dart';
import 'package:demo_chart/screens/candle_stick_full_chart_page.dart';
import 'package:demo_chart/screens/chart_page.dart';
import 'package:demo_chart/screens/pie_chart_page.dart';
import 'package:demo_chart/screens/simulator_chart_page.dart';
import 'package:demo_chart/screens/small_chart_page.dart';
import 'package:demo_chart/utils/urls.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.white, // Color for Android
        statusBarBrightness:
            Brightness.dark // Dark == white status bar -- for IOS.
        ));

    return MaterialApp(
      title: 'Flutter Movie',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        unselectedWidgetColor: Colors.white,
      ),
      initialRoute: Urls.chart,
      routes: {
        Urls.chart: (context) => const ChartPage(),
        Urls.pieChart: (context) => const PieChartPage(),
        Urls.candleStickChart: (context) => const CandleStickChartPage(),
        Urls.simulatorChart: (context) => const SimulatorChartPage(),
        Urls.smallChart: (context) => const SmallChartPage(),
        Urls.candleStickFullChart: (context) => const CandleStickFullChartPage(),
      },
    );
  }
}
