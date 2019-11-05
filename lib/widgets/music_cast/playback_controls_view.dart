import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wakeandshut/services/music_cast/index.dart';

class PlaybackControlsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var state = Provider.of<MCMainState>(context);
    var playInfo = state.playInfo;
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Opacity(
              opacity: playInfo.isShuffleOn ? 1.0 : 0.5,
              child: Icon(Icons.shuffle),
            ),
            onPressed: () {
              // TODO:
            },
          ),
          IconButton(
            icon: Icon(Icons.skip_previous),
            onPressed: () {
              // TODO:
            },
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
            onPressed: () {
              // TODO:
            },
          ),
          IconButton(
            icon: Opacity(
              opacity: playInfo.isRepeatOff ? 0.5 : 1.0,
              child:
                  Icon(playInfo.isRepeatOne ? Icons.repeat_one : Icons.repeat),
            ),
            onPressed: () {
              // TODO:
            },
          ),
        ],
      ),
    );
  }
}
