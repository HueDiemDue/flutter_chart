import 'package:demo_chart/data/simulator_chart_data.dart';

List<SplineData> splines = [
  SplineData(1, 1.5),
  SplineData(2, 2),
  SplineData(3, 3),
];

List<SplineData> newSplines = [
  SplineData(1, 3),
  SplineData(2, 2),
  SplineData(3, 1.5),
];

List<SplineData> splinesOverLimit = [
  SplineData(1, 1.5),
  SplineData(1.5, 2),
  SplineData(2, 1.5),
  SplineData(2.5, 3.4),
  SplineData(3, 1.5),
  SplineData(3.5, 2.5),
  SplineData(4, 1),
];

List<SplineData> newSplinesOverLimit = [
  SplineData(1, 5),
  SplineData(1.5, 3),
  SplineData(2, 3),
  SplineData(2.5, 0),
  SplineData(3, 1.5),
  SplineData(3.5, 3),
  SplineData(4, 1.5),
];

List<SplineData> standardY = [
  SplineData(0.5, 0),
  SplineData(2, 0),
  SplineData(3.5, 0),
];

List<SplineData> standardLimit = [
  SplineData(0.5, 2),
  SplineData(2, 2),
  SplineData(5, 2),
];
