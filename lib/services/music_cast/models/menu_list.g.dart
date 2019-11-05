// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MenuList _$MenuListFromJson(Map<String, dynamic> json) {
  return MenuList(
    responseCode: json['response_code'] as int,
    input: json['input'] as String,
    menuLayer: json['menu_layer'] as int,
    maxLine: json['max_line'] as int,
    index: json['index'] as int,
    playingIndex: json['playing_index'] as int,
    menuName: json['menu_name'] as String,
    listInfo: (json['list_info'] as List)
        ?.map((e) =>
            e == null ? null : MenuListInfo.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$MenuListToJson(MenuList instance) => <String, dynamic>{
      'response_code': instance.responseCode,
      'input': instance.input,
      'menu_layer': instance.menuLayer,
      'max_line': instance.maxLine,
      'index': instance.index,
      'playing_index': instance.playingIndex,
      'menu_name': instance.menuName,
      'list_info': instance.listInfo,
    };

MenuListInfo _$MenuListInfoFromJson(Map<String, dynamic> json) {
  return MenuListInfo(
    text: json['text'] as String,
    thumbnail: json['thumbnail'] as String,
    attribute: json['attribute'] as int,
  );
}

Map<String, dynamic> _$MenuListInfoToJson(MenuListInfo instance) =>
    <String, dynamic>{
      'text': instance.text,
      'thumbnail': instance.thumbnail,
      'attribute': instance.attribute,
    };
