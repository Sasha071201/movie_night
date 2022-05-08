extension StringExtension on DateTime {
  String asApiString() {
    return '$year-${month < 10 ? '0$month' : month}-${day < 10 ? '0$day' : day}';
  }
}