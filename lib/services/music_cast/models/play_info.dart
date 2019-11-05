import 'package:json_annotation/json_annotation.dart';

part 'play_info.g.dart';

@JsonSerializable(nullable: true, fieldRename: FieldRename.snake)
class PlayInfo {
  int responseCode;
  String input;
  String playQueueType;
  String playback;
  String repeat;
  String shuffle;
  int playTime;
  int totalTime;
  String artist;
  String album;
  String track;
  String albumartUrl;
  int albumartId;
  String usbDevicetype;
  bool autoStopped;
  int attribute;
  List<String> repeatAvailable;
  List<String> shuffleAvailable;

  bool get isPlaybackPause => playback == "pause";
  bool get isPlaybackPlay => playback == "play";
  bool get isPlaybackStop => playback == "stop";

  bool get isRepeatOff => repeat == "off";
  bool get isRepeatOne => repeat == "one";
  bool get isRepeatAll => repeat == "all";

  bool get isShuffleOn => shuffle == "on";

  PlayInfo({
    this.responseCode,
    this.input,
    this.playQueueType,
    this.playback,
    this.repeat,
    this.shuffle,
    this.playTime,
    this.totalTime,
    this.artist,
    this.album,
    this.track,
    this.albumartUrl,
    this.albumartId,
    this.usbDevicetype,
    this.autoStopped,
    this.attribute,
    this.repeatAvailable,
    this.shuffleAvailable,
  });

  factory PlayInfo.fromJson(Map<String, dynamic> json) {
    return _$PlayInfoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$PlayInfoToJson(this);
  }
}
