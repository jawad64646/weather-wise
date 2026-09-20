import 'package:intl/intl.dart';

extension Formatdatetime on DateTime {
  String formatDateTime() {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    final hour = this.hour % 12 == 0 ? 12 : this.hour % 12;
    final minute = this.minute.toString().padLeft(2, '0');
    final period = this.hour >= 12 ? 'PM' : 'AM';

    return '$day ${months[month - 1]} • '
        '$hour:$minute $period';
  }

  /// Formats the date to a string like "June 1"
  String toMonthDayString() {
    return DateFormat('MMMM d').format(this);
  }

  String getWeekdayName() {
    switch (weekday) {
      case DateTime.monday:
        return 'Monday';
      case DateTime.tuesday:
        return 'Tuesday';
      case DateTime.wednesday:
        return 'Wednesday';
      case DateTime.thursday:
        return 'Thursday';
      case DateTime.friday:
        return 'Friday';
      case DateTime.saturday:
        return 'Saturday';
      case DateTime.sunday:
        return 'Sunday';
      default:
        return "No day";
    }
  }
}
