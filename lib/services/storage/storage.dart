import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:wakeandshut/model/service_record.dart';

class Storage extends ChangeNotifier {
  final _servicePrefix = 'service.';
  static final Uuid _uuid = Uuid();

  static String nextId() {
    return _uuid.v1();
  }

  SharedPreferences _pref;

  init() async {
    _pref = await SharedPreferences.getInstance();
  }

  List<String> getRecordIds() {
    return _pref
        .getKeys()
        .where((it) => it.startsWith(_servicePrefix))
        .map((it) => it.replaceFirst(_servicePrefix, ""))
        .toList();
  }

  ServiceRecord getRecord(String id) {
    String value = _pref.getString("$_servicePrefix$id");
    if (value == null) {
      value = '{}';
    }
    return ServiceRecord.fromMap(jsonDecode(value));
  }

  void putRecord(ServiceRecord item) {
    if (item.id.isEmpty) {
      item.id = nextId();
    }
    _pref.setString("$_servicePrefix${item.id}", jsonEncode(item.toMap()));
    notifyListeners();
  }

  void deleteRecord(String id) {
    _pref.remove("$_servicePrefix$id");
    notifyListeners();
  }
}
