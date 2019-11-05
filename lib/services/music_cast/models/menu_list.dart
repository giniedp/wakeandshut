import 'package:json_annotation/json_annotation.dart';

part 'menu_list.g.dart';

@JsonSerializable(nullable: true, fieldRename: FieldRename.snake)
class MenuList {
  int responseCode;
  String input;
  int menuLayer;
  int maxLine;
  int index;
  int playingIndex;
  String menuName;
  List<MenuListInfo> listInfo;

  MenuList({
    this.responseCode,
    this.input,
    this.menuLayer,
    this.maxLine,
    this.index,
    this.playingIndex,
    this.menuName,
    this.listInfo,
  });

  factory MenuList.fromJson(Map<String, dynamic> json) {
    return _$MenuListFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MenuListToJson(this);
  }
}

@JsonSerializable(nullable: true, fieldRename: FieldRename.snake)
class MenuListInfo {
  String text;
  String thumbnail;
  int attribute;

  bool get isPlayable => attribute == 84;

  MenuListInfo({
    this.text,
    this.thumbnail,
    this.attribute,
  });

  factory MenuListInfo.fromJson(Map<String, dynamic> json) {
    return _$MenuListInfoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MenuListInfoToJson(this);
  }
}
