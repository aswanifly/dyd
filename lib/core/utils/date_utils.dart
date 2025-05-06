import 'package:intl/intl.dart';

class DateFormatUtil {
  static String convertIsoToMonthAndDay(String date) {
    String formattedDate = "";
    if (date.isEmpty) {
      return formattedDate;
    }
    String isoString = date;
    DateTime dateTime = DateTime.parse(isoString);
    formattedDate = DateFormat('MMM d').format(dateTime);
    return formattedDate;
  }
}
