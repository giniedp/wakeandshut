import 'package:json_annotation/json_annotation.dart';

part 'location_info.g.dart';

@JsonSerializable(nullable: true, fieldRename: FieldRename.snake)
class LocationInfo {
  int responseCode;
  String id;
  String name;
  String stereoPairStatus;
  Map<String, dynamic> zoneList;

  LocationInfo({
    this.responseCode,
    this.id,
    this.name,
    this.stereoPairStatus,
    this.zoneList,
  });

  factory LocationInfo.fromJson(Map<String, dynamic> json) {
    return _$LocationInfoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$LocationInfoToJson(this);
  }
}
