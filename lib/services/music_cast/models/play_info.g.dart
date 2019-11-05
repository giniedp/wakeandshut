// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'play_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayInfo _$PlayInfoFromJson(Map<String, dynamic> json) {
  return PlayInfo(
    responseCode: json['response_code'] as int,
    input: json['input'] as String,
    playQueueType: json['play_queue_type'] as String,
    playback: json['playback'] as String,
    repeat: json['repeat'] as String,
    shuffle: json['shuffle'] as String,
    playTime: json['play_time'] as int,
    totalTime: json['total_time'] as int,
    artist: json['artist'] as String,
    album: json['album'] as String,
    track: json['track'] as String,
    albumartUrl: json['albumart_url'] as String,
    albumartId: json['albumart_id'] as int,
    usbDevicetype: json['usb_devicetype'] as String,
    autoStopped: json['auto_stopped'] as bool,
    attribute: json['attribute'] as int,
    repeatAvailable:
        (json['repeat_available'] as List)?.map((e) => e as String)?.toList(),
    shuffleAvailable:
        (json['shuffle_available'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$PlayInfoToJson(PlayInfo instance) => <String, dynamic>{
      'response_code': instance.responseCode,
      'input': instance.input,
      'play_queue_type': instance.playQueueType,
      'playback': instance.playback,
      'repeat': instance.repeat,
      'shuffle': instance.shuffle,
      'play_time': instance.playTime,
      'total_time': instance.totalTime,
      'artist': instance.artist,
      'album': instance.album,
      'track': instance.track,
      'albumart_url': instance.albumartUrl,
      'albumart_id': instance.albumartId,
      'usb_devicetype': instance.usbDevicetype,
      'auto_stopped': instance.autoStopped,
      'attribute': instance.attribute,
      'repeat_available': instance.repeatAvailable,
      'shuffle_available': instance.shuffleAvailable,
    };
