import 'package:json_annotation/json_annotation.dart';

part 'device_info.g.dart';

@JsonSerializable(nullable: true, fieldRename: FieldRename.snake)
class DeviceInfo {
  int responseCode;
  String modelName;
  String destination;
  String deviceId;
  String systemId;
  double systemVersion;
  double apiVersion;
  int netmoduleGeneration;
  String netmoduleVersion;
  String netmoduleChecksum;
  String operationMode;
  String updateErrorCode;

  DeviceInfo({
    this.responseCode,
    this.modelName,
    this.destination,
    this.deviceId,
    this.systemId,
    this.systemVersion,
    this.apiVersion,
    this.netmoduleGeneration,
    this.netmoduleVersion,
    this.netmoduleChecksum,
    this.operationMode,
    this.updateErrorCode,
  });

  factory DeviceInfo.fromJson(Map<String, dynamic> json) {
    return _$DeviceInfoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$DeviceInfoToJson(this);
  }
}
