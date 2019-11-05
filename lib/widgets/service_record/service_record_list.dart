import 'package:flutter/material.dart';
import 'package:flutter_mdns_plugin/flutter_mdns_plugin.dart';
import 'package:provider/provider.dart';
import 'package:wakeandshut/services/index.dart';

import 'service_info_list_item.dart';
import 'service_record_list_item.dart';

class ServiceRecordList extends StatelessWidget {
  final List<String> ids;
  final List<ServiceInfo> services;

  ServiceRecordList({
    @required this.ids,
    @required this.services,
  });

  List<Widget> getChildrenList(BuildContext context) {
    List<Widget> result = [];
    var storage = Provider.of<Storage>(context);
    var records = ids.map((id) => storage.getRecord(id)).toList();
    result.addAll(records.map((it) => ServiceRecordListItem(item: it)));
    result.addAll(services
        .where((it) => records.every((r) => r.service != it.name))
        .map((it) => ServiceInfoListItem(item: it)));
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: ListTile.divideTiles(
        tiles: getChildrenList(context),
        context: context,
      ).toList(),
    );
  }
}
