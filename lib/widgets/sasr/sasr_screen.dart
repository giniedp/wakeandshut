import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wakeandshut/services/sasr/index.dart';
import 'package:wakeandshut/services/wol/wol_client.dart';
import 'package:wakeandshut/widgets/views/index.dart';

class SasrScreen extends StatelessWidget {
  final SasrApi sasrClient;
  final WolClient wolClient;

  bool get isAwake {
    return sasrClient?.info != null && sasrClient.info.port > 0;
  }

  SasrScreen({
    @required this.sasrClient,
    @required this.wolClient,
  });

  List<Widget> getChildrenList(BuildContext context) {
    List<Widget> result = [];
    if (sasrClient.info != null) {
      result.addAll([
        Padding(
          padding: EdgeInsets.all(16),
          child: PropertyTableView(item: sasrClient.info.toMap()),
        ),
      ]);
    }

    result.addAll([
      ListTile(
        title: Text('Wake up'),
        leading: Icon(FontAwesomeIcons.clock),
        onTap: () => _withConfirm(
          context,
          title: 'Wake up',
          message:
              'This will send a wake on lan request to ${wolClient.address}',
          onCancel: () => Navigator.pop(context),
          onOk: () {
            Navigator.pop(context);
            wolClient.wake();
          },
        ),
      ),
    ]);
    if (isAwake) {
      result.addAll([
        ListTile(
          title: Text('Shut down'),
          leading: Icon(FontAwesomeIcons.powerOff),
          onTap: () => _withConfirm(
            context,
            title: 'Shut down',
            message:
                'This will send a shut down request to ${sasrClient.info.name}',
            onCancel: () => Navigator.pop(context),
            onOk: () {
              Navigator.pop(context);
              sasrClient.shutdown();
            },
          ),
        ),
        ListTile(
          title: Text('Hibernate'),
          leading: Icon(FontAwesomeIcons.bed),
          onTap: () => _withConfirm(
            context,
            title: 'Hibernate',
            message:
                'This will send a hibernate request to ${sasrClient.info.name}',
            onCancel: () => Navigator.pop(context),
            onOk: () {
              Navigator.pop(context);
              sasrClient.hibernate();
            },
          ),
        ),
        ListTile(
          title: Text('Reboot'),
          leading: Icon(FontAwesomeIcons.sync),
          onTap: () => _withConfirm(
            context,
            title: 'Reboot',
            message:
                'This will send a reboot request to ${sasrClient.info.name}',
            onCancel: () => Navigator.pop(context),
            onOk: () {
              Navigator.pop(context);
              sasrClient.reboot();
            },
          ),
        ),
      ]);
    }
    return result;
  }

  _withConfirm(BuildContext context,
      {String title, String message, Function onOk, Function onCancel}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            FlatButton(
              child: Text('Cancel'),
              onPressed: onCancel,
            ),
            FlatButton(
              child: Text('OK'),
              onPressed: onOk,
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${sasrClient?.info?.name ?? ''}"),
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
