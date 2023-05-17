//Parse time into MMMMDDYY
String convertToDate(String dateString) {
  final Map<int, String> monthMap = {
    1: 'January',
    2: 'February',
    3: 'March',
    4: 'April',
    5: 'May',
    6: 'June',
    7: 'July',
    8: 'August',
    9: 'September',
    10: 'October',
    11: 'November',
    12: 'December',
  };

  final month = int.parse(dateString.substring(0, 2));
  final day = int.parse(dateString.substring(2, 4));
  final year = int.parse(dateString.substring(4));

  final formattedMonth = monthMap[month] ?? '';
  final formattedDate = '$formattedMonth $day, $year';

  return formattedDate;
}

//  date time in number format

String formatDate(DateTime dateTime) {
  final day = dateTime.day.toString().padLeft(2, '0');
  final month = dateTime.month.toString().padLeft(2, '0');
  final year = dateTime.year.toString().substring(2);

  return '$month$day$year';
}
