import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wakeandshut/services/music_cast/index.dart';

class PlayQueueScreen extends StatelessWidget {
  static Future<MaterialPageRoute> navigate(
      BuildContext context, MCMainState state) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return ChangeNotifierProvider.value(
            value: state,
            child: PlayQueueScreen(),
          );
        },
      ),
    );
  }

  static List<Widget> buildQueueList(
    BuildContext context,
    MCMainState state,
  ) {
    var queue = state.playQueue;

    List<Widget> result = [];

    if ((queue?.trackInfo?.length ?? 0) == 0) {
      return result;
    }

    queue.trackInfo.forEach((it) {
      result.add(
        ListTile(
          title: Text(it.text ?? ''),
          subtitle: Text(it.input ?? ''),
          leading: it.thumbnail.isNotEmpty ? Image.network(it.thumbnail) : null,
          trailing: queue.playingIndex == queue.trackInfo.indexOf(it)
              ? Icon(Icons.headset)
              : null,
        ),
      );
    });

    return result;
  }

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<MCMainState>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Queue"),
      ),
      body: ListView(
        children: ListTile.divideTiles(
          tiles: buildQueueList(context, state),
          context: context,
        ).toList(),
      ),
    );
  }
}
