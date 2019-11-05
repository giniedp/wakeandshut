// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'status_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatusInfo _$StatusInfoFromJson(Map<String, dynamic> json) {
  return StatusInfo(
    responseCode: json['response_code'] as int,
    power: json['power'] as String,
    sleep: json['sleep'] as int,
    volume: json['volume'] as int,
    mute: json['mute'] as bool,
    maxVolume: json['max_volume'] as int,
    input: json['input'] as String,
    distributionEnable: json['distribution_enable'] as bool,
    equalizer: json['equalizer'] == null
        ? null
        : EqualizerInfo.fromJson(json['equalizer'] as Map<String, dynamic>),
    linkControl: json['link_control'] as String,
    linkAudioQuality: json['link_audio_quality'] as String,
    disableFlags: json['disable_flags'] as int,
  );
}

Map<String, dynamic> _$StatusInfoToJson(StatusInfo instance) =>
    <String, dynamic>{
      'response_code': instance.responseCode,
      'power': instance.power,
      'sleep': instance.sleep,
      'volume': instance.volume,
      'mute': instance.mute,
      'max_volume': instance.maxVolume,
      'input': instance.input,
      'distribution_enable': instance.distributionEnable,
      'equalizer': instance.equalizer,
      'link_control': instance.linkControl,
      'link_audio_quality': instance.linkAudioQuality,
      'disable_flags': instance.disableFlags,
    };

EqualizerInfo _$EqualizerInfoFromJson(Map<String, dynamic> json) {
  return EqualizerInfo(
    mode: json['mode'] as String,
    low: json['low'] as int,
    mid: json['mid'] as int,
    high: json['high'] as int,
  );
}

Map<String, dynamic> _$EqualizerInfoToJson(EqualizerInfo instance) =>
    <String, dynamic>{
      'mode': instance.mode,
      'low': instance.low,
      'mid': instance.mid,
      'high': instance.high,
    };
