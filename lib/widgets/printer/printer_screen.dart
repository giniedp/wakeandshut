import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wakeandshut/services/printer/printer_client.dart';
import 'package:wakeandshut/widgets/views/index.dart';

class PrinterScreen extends StatelessWidget {
  final PrinterClient client;

  PrinterScreen({
    @required this.client,
  });

  List<Widget> getChildrenList(BuildContext context) {
    List<Widget> result = [];
    if (client.info != null) {
      result.addAll([
        Padding(
          padding: EdgeInsets.all(16),
          child: PropertyTableView(item: client.info.toMap()),
        ),
      ]);
    }
    result.addAll([
      ListTile(
        title: Text('Open in browser'),
        leading: Icon(FontAwesomeIcons.globe),
        onTap: () => client.openInBrowser(),
      ),
    ]);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${client?.info?.name ?? ''}"),
      ),
      body: ListView(
        children: ListTile.divideTiles(
          tiles: getChildrenList(context),
          context: context,
        ).toList(),
      ),
    );
  }
}
