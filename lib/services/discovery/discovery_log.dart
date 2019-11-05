import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wakeandshut/model/log_record.dart';

class DiscoveryLog extends ChangeNotifier {
  final List<LogRecord> _history = <LogRecord>[];

  UnmodifiableListView<LogRecord> get items => UnmodifiableListView(_history);

  void write(String message) {
    _history.insert(0, LogRecord(time: DateTime.now(), message: message));
    _history.length = min(_history.length, 1000);
    notifyListeners();
  }
}
