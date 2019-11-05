import 'package:json_annotation/json_annotation.dart';

part 'status_info.g.dart';

@JsonSerializable(nullable: true, fieldRename: FieldRename.snake)
class StatusInfo {
  int responseCode;
  String power;
  int sleep;
  int volume;
  bool mute;
  int maxVolume;
  String input;
  bool distributionEnable;
  EqualizerInfo equalizer;
  String linkControl;
  String linkAudioQuality;
  int disableFlags;

  bool get isPowerOn => power == "on";
  
  StatusInfo({
    this.responseCode,
    this.power,
    this.sleep,
    this.volume,
    this.mute,
    this.maxVolume,
    this.input,
    this.distributionEnable,
    this.equalizer,
    this.linkControl,
    this.linkAudioQuality,
    this.disableFlags,
  });

  factory StatusInfo.fromJson(Map<String, dynamic> json) {
    return _$StatusInfoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$StatusInfoToJson(this);
  }
}

@JsonSerializable(nullable: true, fieldRename: FieldRename.snake)
class EqualizerInfo {
  String mode;
  int low;
  int mid;
  int high;

  EqualizerInfo({
    this.mode,
    this.low,
    this.mid,
    this.high,
  });

  factory EqualizerInfo.fromJson(Map<String, dynamic> json) {
    return _$EqualizerInfoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$EqualizerInfoToJson(this);
  }
}
