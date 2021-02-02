extension StringExt on String {
  String get capcapitalize => "${this[0].toUpperCase()}${this.substring(1)}";
}
