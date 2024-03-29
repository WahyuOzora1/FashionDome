part of 'package:flutterapotek/core.dart';

final List<String> _monthNames = [
  'Januari',
  'Februari',
  'Maret',
  'April',
  'Mei',
  'Juni',
  'Juli',
  'Agustus',
  'September',
  'Oktober',
  'November',
  'Desember'
];

final List<String> _monthNamesShort = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'Mei',
  'Juni',
  'Juli',
  'Agus',
  'Sept',
  'Okt',
  'Nov',
  'Des'
];

extension DateTimeExt on DateTime {
  String toFormattedDate() {
    final int day = this.day;
    final String month = _monthNames[this.month - 1];
    final int year = this.year;

    return '$day $month $year';
  }

  String toFormattedDateShort() {
    final int day = this.day;
    final String month = _monthNamesShort[this.month - 1];
    final int year = this.year;

    return '$day, $month $year';
  }

  String toFormattedMonth() {
    final int day = this.day;
    final String month = _monthNames[this.month - 1];

    return '$day $month';
  }

  String toFormattedDateMinute() {
    final int hour = this.hour;
    final int minute = this.minute;
    final int day = this.day;
    final String month = _monthNamesShort[this.month - 1];
    final int year = this.year;

    return '$day $month $year, $hour:$minute';
    // return DateFormat('d MMM y, H:mm a', 'id').format(time);
  }
}
