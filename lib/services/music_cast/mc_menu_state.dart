import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import 'mc_api.dart';
import 'models/menu_list.dart';

class MCMenuState extends ChangeNotifier {
  final MusicCastApi client;
  final String input;
  final String zone;

  MCMenuState({
    @required this.client,
    @required this.input,
    @required this.zone,
  }) {
    assert(client != null);
  }

  final pageSize = 8;
  bool get canGoBack => (_menu?.menuLayer ?? 0) > 0;
  String get menuName => _menu?.menuName ?? "";
  int get playingIndex => _menu?.playingIndex ?? -1;
  int get itemcount => _menu?.maxLine ?? 0;

  MenuList _menu;

  MCMenuState.init({
    @required this.client,
    @required this.input,
    @required this.zone,
  }) {
    assert(client != null);
    list(index: 0);
  }

  void clear() {
    _completers.length = 0;
    notifyListeners();
  }

  var _completers = new List<Completer<MenuListInfo>>();

  Future<MenuListInfo> getItem(int index) {
    int page = index ~/ pageSize;
    _completers.length = max(_completers.length, (page + 1) * pageSize);

    if (_completers[index] == null) {
      int offset = page * pageSize;
      for (var i = 0; i < pageSize; i++) {
        _completers[offset + i] = Completer<MenuListInfo>();
      }

      client
          .getListInfo(
        input: input,
        listId: this.zone,
        size: pageSize,
        index: offset,
      )
          .then((data) {
        data.listInfo.asMap().forEach((i, item) {
          _completers[offset + i].complete(item);
        });
      }).catchError((error) {
        _completers.sublist(offset, offset + pageSize).forEach((completer) {
          completer.completeError(error);
        });
      });
    }
    return _completers[index].future;
  }

  Future<void> list({int index}) async {
    assert(index >= 0);
    _menu = await client.getListInfo(
      input: input,
      listId: this.zone,
      size: pageSize,
      index: index,
    );
    notifyListeners();
  }

  Future<void> select(int index) {
    return client
        .setListControlSelect(zone: this.zone, index: index)
        .then((value) {
      clear();
      list(index: 0);
    }).catchError((err) {
      print(err);
    });
  }

  Future<bool> back() {
    return client.setListControlReturn(zone: this.zone).then((value) {
      clear();
      list(index: 0);
      return true;
    }).catchError((err) {
      print(err);
      return false;
    });
  }
}
