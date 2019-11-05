import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wakeandshut/services/music_cast/index.dart';
import 'package:wakeandshut/widgets/music_cast/play_queue_screen.dart';

class PlaybackInfoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var state = Provider.of<MCMainState>(context);
    var playInfo = state.playInfo;
    return ListTile(
      title: Text(playInfo.track, overflow: TextOverflow.ellipsis),
      subtitle: Text(playInfo.artist, overflow: TextOverflow.ellipsis),
      trailing: IconButton(
        icon: Icon(Icons.queue_music),
        onPressed: () {
          PlayQueueScreen.navigate(context, state);
        },
      ),
    );
  }
}
