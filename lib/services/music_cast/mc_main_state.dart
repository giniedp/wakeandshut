import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wakeandshut/services/music_cast/models/play_info.dart';
import 'package:wakeandshut/services/music_cast/models/play_queue.dart';
import 'package:wakeandshut/services/music_cast/models/status_info.dart';

import 'mc_api.dart';

class MCMainState extends ChangeNotifier {
  final MusicCastApi client;

  StatusInfo status = StatusInfo();
  PlayInfo playInfo = PlayInfo();
  PlayQueue playQueue = PlayQueue();

  Timer _timer;

  MCMainState({@required this.client}) {
    assert(client != null);
  }

  MCMainState.init({@required this.client}) {
    assert(client != null);
    update();
  }

  void activate() {
    deactivate();
    _timer = Timer.periodic(Duration(seconds: 2), (t) => update());
  }

  void deactivate() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  void dispose() {
    super.dispose();
    deactivate();
  }

  void update() {
    Future.wait([
      client.getStatus(),
      client.getPlayInfo(),
      client.getPlayQueue(),
    ]).then((list) {
      this.status = list[0];
      this.playInfo = list[1];
      this.playQueue = list[2];
      notifyListeners();
    });
  }

  void updateStatus() {
    client.getStatus().then((status) {
      this.status = status;
      notifyListeners();
    });
  }

  void updatePlayInfo() {
    client.getPlayInfo().then((info) {
      playInfo = info;
      notifyListeners();
    });
  }

  void updatePlayQueue() {
    client.getPlayQueue().then((info) {
      playQueue = info;
      notifyListeners();
    });
  }

  void setPlaybackPlay() async {
    this.client.setPlaybackPlay().then((_) => this.update());
  }

  void setPlaybackPause() async {
    this.client.setPlaybackPause().then((_) => this.update());
  }

  void setPlaybackStop() async {
    this.client.setPlaybackStop().then((_) => this.update());
  }

  void setPower(bool powerOn) {
    (powerOn ? this.client.setPowerOn() : this.client.setPowerStandby())
        .then((_) => this.update());
  }

  void togglePower() {
    this.client.setPowerToggle().then((_) => this.update());
  }
}
