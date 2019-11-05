// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceInfo _$DeviceInfoFromJson(Map<String, dynamic> json) {
  return DeviceInfo(
    responseCode: json['response_code'] as int,
    modelName: json['model_name'] as String,
    destination: json['destination'] as String,
    deviceId: json['device_id'] as String,
    systemId: json['system_id'] as String,
    systemVersion: (json['system_version'] as num)?.toDouble(),
    apiVersion: (json['api_version'] as num)?.toDouble(),
    netmoduleGeneration: json['netmodule_generation'] as int,
    netmoduleVersion: json['netmodule_version'] as String,
    netmoduleChecksum: json['netmodule_checksum'] as String,
    operationMode: json['operation_mode'] as String,
    updateErrorCode: json['update_error_code'] as String,
  );
}

Map<String, dynamic> _$DeviceInfoToJson(DeviceInfo instance) =>
    <String, dynamic>{
      'response_code': instance.responseCode,
      'model_name': instance.modelName,
      'destination': instance.destination,
      'device_id': instance.deviceId,
      'system_id': instance.systemId,
      'system_version': instance.systemVersion,
      'api_version': instance.apiVersion,
      'netmodule_generation': instance.netmoduleGeneration,
      'netmodule_version': instance.netmoduleVersion,
      'netmodule_checksum': instance.netmoduleChecksum,
      'operation_mode': instance.operationMode,
      'update_error_code': instance.updateErrorCode,
    };
