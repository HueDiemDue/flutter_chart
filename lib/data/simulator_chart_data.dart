class SplineAreaData {
  SplineAreaData(this.xValue, this.lowValue, this.highValue);

  final double xValue;
  final double lowValue;
  final double highValue;
}

class SplineData {
  SplineData(this.xValue, this.yValue);

  final double xValue;
  final double yValue;
}

final List<SplineAreaData> splineArea = [
  SplineAreaData(0, 0, 0),
  SplineAreaData(1, 0.2, 1),
  SplineAreaData(3, 1, 4),
];

final List<SplineData> splineData = [
  SplineData(0, 0),
  SplineData(1.5, 0.5),
  SplineData(3, 1.5),
];
final List<SplineData> splineDataLower = [
  SplineData(0, 0),
  SplineData(2, 1),
  SplineData(3, 2),
];

final List<SplineAreaData> splineAreaLower = [
  SplineAreaData(0, 0, 0),
  SplineAreaData(1, 0.7, 0.1),
  SplineAreaData(3, 1, 3),
];

final List<SplineData> smallData = [
  SplineData(1, 1.5),
  SplineData(2, 2),
  SplineData(3, 3),
];