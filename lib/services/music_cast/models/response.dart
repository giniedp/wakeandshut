import 'package:json_annotation/json_annotation.dart';

part 'response.g.dart';

@JsonSerializable(nullable: true, fieldRename: FieldRename.snake)
class Response {
  int responseCode;

  Response({
    this.responseCode,
  });

  factory Response.fromJson(Map<String, dynamic> json) {
    return _$ResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ResponseToJson(this);
  }
}
