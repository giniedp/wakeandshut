// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'play_queue.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayQueue _$PlayQueueFromJson(Map<String, dynamic> json) {
  return PlayQueue(
    responseCode: json['response_code'] as int,
    type: json['type'] as String,
    maxLine: json['max_line'] as int,
    playingIndex: json['playing_index'] as int,
    index: json['index'] as int,
    trackInfo: (json['track_info'] as List)
        ?.map((e) =>
            e == null ? null : TrackInfo.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$PlayQueueToJson(PlayQueue instance) => <String, dynamic>{
      'response_code': instance.responseCode,
      'type': instance.type,
      'max_line': instance.maxLine,
      'playing_index': instance.playingIndex,
      'index': instance.index,
      'track_info': instance.trackInfo,
    };

TrackInfo _$TrackInfoFromJson(Map<String, dynamic> json) {
  return TrackInfo(
    input: json['input'] as String,
    text: json['text'] as String,
    thumbnail: json['thumbnail'] as String,
    attribute: json['attribute'] as int,
  );
}

Map<String, dynamic> _$TrackInfoToJson(TrackInfo instance) => <String, dynamic>{
      'input': instance.input,
      'text': instance.text,
      'thumbnail': instance.thumbnail,
      'attribute': instance.attribute,
    };
