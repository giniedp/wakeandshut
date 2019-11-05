import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_mdns_plugin/flutter_mdns_plugin.dart';

class DiscoveryList extends ChangeNotifier {
  final List<ServiceInfo> _list = <ServiceInfo>[];

  UnmodifiableListView<ServiceInfo> get items => UnmodifiableListView(_list);

  void put(ServiceInfo info) {
    _list.removeWhere((it) => it.name == info.name);
    _list.add(info);
    _list.sort((a, b) => a.name.compareTo(b.name));
    notifyListeners();
  }

  void delete(ServiceInfo info) {
    _list.removeWhere((it) => it.name == info.name);
    notifyListeners();
  }

  void clear() {
    _list.clear();
    notifyListeners();
  }
}
