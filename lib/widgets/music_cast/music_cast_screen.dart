import 'package:device_apps/device_apps.dart';
import 'package:flutter_mdns_plugin/flutter_mdns_plugin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wakeandshut/services/music_cast/index.dart';
import 'package:wakeandshut/widgets/music_cast/playback_info_view.dart';

import 'menu_list_screen.dart';
import 'playback_controls_view.dart';

class MusicCastScreen extends StatelessWidget {
  List<Widget> getChildrenList(BuildContext context) {
    var state = Provider.of<MCMainState>(context);
    var isOn = state.status.power == "on";
    List<Widget> result = [];

    if (isOn && (state.playInfo.track ?? "").isNotEmpty) {
      result.addAll([
        PlaybackInfoView(),
        Image.network(
          state.client.imageUrl(state.playInfo.albumartUrl),
          fit: BoxFit.fitWidth,
          width: MediaQuery.of(context).size.width,
        ),
        PlaybackControlsView(),
      ]);
    }

    result.add(
      ListTile(
        title: Text("Radio"),
        onTap: () {
          MenuListScreen.navigate(
            context: context,
            input: "net_radio",
            client: state.client,
          );
        },
      ),
    );
    result.add(
      ListTile(
        title: Text("Server"),
        onTap: () {
          MenuListScreen.navigate(
            context: context,
            input: "server",
            client: state.client,
          );
        },
      ),
    );
    return result;
  }

  @override
  Widget build(BuildContext context) {
    var info = Provider.of<ServiceInfo>(context);
    var state = Provider.of<MCMainState>(context);
    var isOn = state.status?.power == "on";

    return Scaffold(
      appBar: AppBar(
        title: Text("${info.name}"),
        actions: <Widget>[
          IconButton(
            icon: Opacity(
              opacity: isOn ? 1.0 : 0.5,
              child: Icon(FontAwesomeIcons.powerOff),
            ),
            onPressed: () {
              state.togglePower();
            },
          ),
          PopupMenuButton<int>(
            onSelected: (value) {
              switch (value) {
                case 0:
                  DeviceApps.openApp('com.yamaha.av.musiccastcontroller');
                  break;
                case 1:
                  Provider.of<MusicCastApi>(context).openInBrowser();
                  break;
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<int>(
                  value: 0,
                  child: Text('Open App'),
                ),
                PopupMenuItem<int>(
                  value: 1,
                  child: Text('Open Webpage'),
                )
              ];
            },
          ),
        ],
      ),
      body: isOn
          ? ListView(
              children: ListTile.divideTiles(
                tiles: getChildrenList(context),
                context: context,
              ).toList(),
            )
          : Container(
              decoration: BoxDecoration(color: Colors.blueGrey),
              child: Center(
                child: Text(
                  "System Power is Off",
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
              ),
            ),
    );
  }
}
