import 'package:json_annotation/json_annotation.dart';

part 'play_queue.g.dart';

@JsonSerializable(nullable: true, fieldRename: FieldRename.snake)
class PlayQueue {
  int responseCode;
  String type;
  int maxLine;
  int playingIndex;
  int index;
  List<TrackInfo> trackInfo;

  PlayQueue({
    this.responseCode,
    this.type,
    this.maxLine,
    this.playingIndex,
    this.index,
    this.trackInfo,
  });

  factory PlayQueue.fromJson(Map<String, dynamic> json) {
    return _$PlayQueueFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$PlayQueueToJson(this);
  }
}

@JsonSerializable(nullable: true, fieldRename: FieldRename.snake)
class TrackInfo {
  String input;
  String text;
  String thumbnail;
  int attribute;

  /// b[0] Name exceeds max byte limit (common for all Net/USB sources)
  bool get isNameExceedsMaxByteLimit => attribute & 1 == 1;
  /// b[1] Capable of Select (common for all Net/USB sources)
  bool get isCapableOfSelect => attribute & 2 == 2;
  /// b[2] Capable of Play (common for all Net/USB sources)
  bool get isCapableOfPlay => attribute & 4 == 4;
  /// b[3] Capable of Search (Rhapsody / Napster / JUKE)
  bool get isCapableOfSearch => attribute & 8 == 8;
  /// b[4] Album Art available (common for all Net/USB sources)
  bool get isAlbumArtAvailable => attribute & 16 == 16;
  // b[5] Now Playing (Pandora)
  bool get isNowPlaying => attribute & 32 == 32;

  // b[6] Capable of Add Bookmark (Net Radio)
  // b[7] Capable of Add Track (Rhapsody / Napster / JUKE / Qobuz)
  // b[8] Capable of Add Album (Rhapsody / Napster / JUKE / Qobuz)
  // b[9] Capable of Add Channel (Rhapsody / Napster / Pandora)
  // b[10] Capable of Remove Bookmark (Net Radio)
  // b[11] Capable of Remove Track (Rhapsody / Napster / JUKE / Qobuz)
  // b[12] Capable of Remove Album (Rhapsody / Napster / JUKE / Qobuz)
  // b[13] Capable of Remove Channel (Rhapsody / Napster / Pandora)
  // b[14] Capable of Remove Playlist (Rhapsody / Qobuz)
  // b[15] Playlist (JUKE / Qobuz)
  // b[16] Radio (JUKE)
  // b[17] Shuffle (Pandora)
  // b[18] Shared Station (Pandora)
  // b[19] Premium Item (radiko)
  // b[20] Capable of Add Artist (Qobuz)
  // b[21] Capable of Remove Artist (Qobuz)
  // b[22] Capable of Add Playlist (Qobuz)
  // b[23] Capable of Play Now
  // b[24] Capable of Play Next
  // b[25] Capable of Add Play Queue
  // b[26] Capable of Add MusicCast Playlist


  TrackInfo({
    this.input,
    this.text,
    this.thumbnail,
    this.attribute,
  });

  factory TrackInfo.fromJson(Map<String, dynamic> json) {
    return _$TrackInfoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$TrackInfoToJson(this);
  }
}
