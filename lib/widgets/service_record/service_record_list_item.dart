import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wakeandshut/services/discovery/index.dart';
import 'package:wakeandshut/model/service_record.dart';
import 'package:wakeandshut/services/music_cast/index.dart';
import 'package:wakeandshut/services/printer/index.dart';
import 'package:wakeandshut/services/sasr/index.dart';
import 'package:wakeandshut/services/wol/index.dart';
import 'package:wakeandshut/widgets/music_cast/music_cast_screen.dart';
import 'package:wakeandshut/widgets/printer/printer_screen.dart';
import 'package:wakeandshut/widgets/sasr/sasr_screen.dart';

import 'service_record_form.dart';

class ServiceRecordListItem extends StatelessWidget {
  final ServiceRecord item;

  ServiceRecordListItem({@required this.item});

  _onTap(BuildContext context) {
    var info = Provider.of<DiscoveryList>(context)
        .items
        .firstWhere((it) => it.name == item.service, orElse: () => null);

    if (item.kind == ServiceKind.Sasr) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return SasrScreen(
            sasrClient: SasrApi(info: info),
            wolClient: WolClient(mac: item.mac, address: item.address),
          );
        }),
      );
    }

    if (item.kind == ServiceKind.Printer && info != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return PrinterScreen(client: PrinterClient(info: info));
          },
        ),
      );
    }

    if (item.kind == ServiceKind.MusicCast && info != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          var client = MusicCastApi(info: info);
          var state = MCMainState.init(client: client);
          return MultiProvider(
            providers: [
              Provider.value(value: info),
              Provider.value(value: client),
              ChangeNotifierProvider.value(value: state),
            ],
            child: MusicCastScreen(),
          );
        }),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var resolved = Provider.of<DiscoveryList>(context)
        .items
        .where((it) => it.name == item.service)
        .any((it) => it.port > 0);
    return ListTile(
      title: Text(item.kind.toString().split(".")[1]),
      subtitle: Opacity(
        opacity: 0.5,
        child: Text(item.service),
      ),
      trailing: Opacity(
        opacity: resolved ? 1.0 : 0.25,
        child: Icon(FontAwesomeIcons.plug),
      ),
      onLongPress: () => ServiceRecordForm.navigate(context, record: item),
      onTap: () => _onTap(context),
    );
  }
}
