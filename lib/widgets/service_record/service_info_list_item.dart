import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mdns_plugin/flutter_mdns_plugin.dart';
import 'package:wakeandshut/widgets/service_record/index.dart';

class ServiceInfoListItem extends StatelessWidget {
  final ServiceInfo item;

  bool get isResolved {
    return item.port > 0;
  }

  ServiceInfoListItem({@required this.item});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Opacity(
        opacity: isResolved ? 1.0 : 0.5,
        child: Text(item.name),
      ),
      onLongPress: () => ServiceRecordForm.navigate(context, info: item),
    );
  }
}
