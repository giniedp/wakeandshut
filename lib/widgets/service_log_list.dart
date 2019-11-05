import 'package:flutter/material.dart';
import 'package:wakeandshut/model/log_record.dart';

class ServiceLogList extends StatelessWidget {
  final List<LogRecord> list;

  ServiceLogList({@required this.list});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: list.map((item) {
        return Text("${item.time.hour}:${item.time.minute} ${item.message}\n", style: TextStyle(fontSize: 12));
      }).toList(),
    );
  }
}
