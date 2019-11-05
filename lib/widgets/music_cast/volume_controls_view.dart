import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wakeandshut/services/music_cast/index.dart';

class VolumeControlsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var state = Provider.of<MCMainState>(context);
    var playInfo = state.playInfo;
    return Container(
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.skip_previous),
            onPressed: () {},
          ),
          IconButton(
            icon:
                Icon(playInfo.isPlaybackPlay ? Icons.pause : Icons.play_arrow),
            onPressed: () {
              if (playInfo.isPlaybackPlay) {
                state.setPlaybackPause();
              } else {
                state.setPlaybackPlay();
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.skip_next),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
