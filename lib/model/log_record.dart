import 'package:flutter/widgets.dart';

class LogRecord {
  final DateTime time;
  final String message;

  LogRecord({@required this.time, @required this.message});
}