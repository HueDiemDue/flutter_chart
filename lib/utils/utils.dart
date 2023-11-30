// getWeekOfYear(DateTime dateTime) {
//   int d = DateTime.parse("${dateTime.year}-01-01").millisecondsSinceEpoch;
//   int t = dateTime.millisecondsSinceEpoch;
//   double daydiff = (t - d) / (1000 * (3600 * 24));
//   double week = daydiff / 7;
//   print('getWeekOfYear ${week.ceil()}');
//   return '1';
// }
getWeekOfYear(DateTime dateTime) {
  final firstDayOfTheMonth = DateTime(dateTime.year, dateTime.month, 1);
  int sum = (firstDayOfTheMonth.weekday - 1 + dateTime.day);
  print('getWeekOfYear ${sum % 7}');
  if (sum % 7 == 0) {
    return (sum ~/ 7).toString();
  } else {
    return (sum ~/ 7 + 1).toString();
  }
}
