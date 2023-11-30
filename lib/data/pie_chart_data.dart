import 'dart:ui';

final List<PieData> pieData = [
  PieData('Received', 45, const Color.fromARGB(255, 9, 9, 9)),
  PieData('Payment', 25, const Color.fromARGB(255, 174, 172, 174)),
  PieData('Other', 30, const Color.fromARGB(255, 64, 63, 64)),
];

final List<PieData> newPieData = [
  PieData('Received', 55, const Color.fromARGB(255, 9, 9, 9)),
  PieData('Payment', 35, const Color.fromARGB(255, 174, 172, 174)),
  PieData('Other', 10, const Color.fromARGB(255, 64, 63, 64)),
];

class PieData {
  PieData(this.x, this.y, this.color);

  final String x;
  final double y;
  final Color color;
}
