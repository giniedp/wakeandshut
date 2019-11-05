// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationInfo _$LocationInfoFromJson(Map<String, dynamic> json) {
  return LocationInfo(
    responseCode: json['response_code'] as int,
    id: json['id'] as String,
    name: json['name'] as String,
    stereoPairStatus: json['stereo_pair_status'] as String,
    zoneList: json['zone_list'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$LocationInfoToJson(LocationInfo instance) =>
    <String, dynamic>{
      'response_code': instance.responseCode,
      'id': instance.id,
      'name': instance.name,
      'stereo_pair_status': instance.stereoPairStatus,
      'zone_list': instance.zoneList,
    };
