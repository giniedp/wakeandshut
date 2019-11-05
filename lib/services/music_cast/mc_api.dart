import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_mdns_plugin/flutter_mdns_plugin.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:wakeandshut/services/music_cast/models/menu_list.dart';
import 'package:wakeandshut/services/music_cast/models/response.dart';
import 'package:wakeandshut/services/music_cast/models/status_info.dart';

import 'models/play_queue.dart';
import 'models/play_info.dart';
import 'models/location_info.dart';
import 'models/device_info.dart';
import 'models/response_code.dart';

class MusicCastApi {
  final ServiceInfo info;
  final http.Client client = http.Client();

  MusicCastApi({@required this.info});

  String get _baseUrl {
    return "http://${info.address}:${info.port}/YamahaExtendedControl/v2";
  }

  String imageUrl(String url) {
    if (url?.startsWith("/YamahaRemoteControl") ?? false) {
      return "http://${info.address}:${info.port}$url";
    }
    return url;
  }

  Future<bool> openInBrowser() async {
    var url = "http://${info.address}";
    if (await canLaunch(url)) {
      launch(url);
      return true;
    }
    return false;
  }

  Future<DeviceInfo> getDeviceInfo() async {
    return _call(
      path: "system/getDeviceInfo",
      transform: (json) => DeviceInfo.fromJson(json),
    );
  }

  Future<LocationInfo> getLocationInfo() async {
    return _call(
      path: "system/getLocationInfo",
      transform: (json) => LocationInfo.fromJson(json),
    );
  }

  Future<PlayInfo> getPlayInfo() async {
    return _call(
      path: "netusb/getPlayInfo",
      transform: (json) => PlayInfo.fromJson(json),
    );
  }

  Future<PlayQueue> getPlayQueue() async {
    return _call(
      path: "netusb/getPlayQueue",
      transform: (json) => PlayQueue.fromJson(json),
    );
  }

  Future<StatusInfo> getStatus() async {
    return _call(
      path: "main/getStatus",
      transform: (json) => StatusInfo.fromJson(json),
    );
  }

  Future<Response> setPowerOn() => setPower("on");
  Future<Response> setPowerStandby() => setPower("stanby");
  Future<Response> setPowerToggle() => setPower("toggle");
  Future<Response> setPower(String power) async {
    return _call(
      path: "main/setPower",
      transform: (json) => Response.fromJson(json),
      params: {
        "power": power,
      },
    );
  }

  Future<Response> setPlaybackPlay() => setPlayback("play");
  Future<Response> setPlaybackStop() => setPlayback("stop");
  Future<Response> setPlaybackPause() => setPlayback("pause");
  Future<Response> setPlayback(String playback) async {
    return _call(
      path: "netusb/setPlayback",
      transform: (json) => Response.fromJson(json),
      params: {
        "playback": playback,
      },
    );
  }

  Future<Response> setListControlPlay({
    int index,
    String zone,
  }) =>
      setListControl(type: "play", index: index, zone: zone);
  Future<Response> setListControlSelect({
    int index,
    String zone,
  }) =>
      setListControl(type: "select", index: index, zone: zone);
  Future<Response> setListControlReturn({
    String zone,
  }) =>
      setListControl(type: "return", zone: zone);
  Future<Response> setListControl({
    String type,
    int index,
    String zone,
  }) async {
    return _call(
      path: "netusb/setListControl",
      transform: (json) => Response.fromJson(json),
      params: {
        "type": type,
        "index": index == null ? null : index.toString(),
        "zone": zone,
      },
    );
  }

  Future<MenuList> getListInfo({
    String listId,
    String input,
    int index = 0,
    int size = 8,
    String lang = "en",
  }) async {
    return _call(
      path: "netusb/getListInfo",
      transform: (json) => MenuList.fromJson(json),
      params: {
        "list_id": listId,
        "input": input,
        "index": index.toString(),
        "size": size.toString(),
        "lang": lang,
      },
    );
  }

  Future<T> _call<T>({
    @required String path,
    Map<String, String> params,
    @required Function transform,
  }) {
    var url = "$_baseUrl/$path";
    if ((params?.length ?? 0) > 0) {
      url += "?";
      url += params.entries
          .where((e) => e.value != null && e.value.isNotEmpty)
          .map<String>((e) => "${e.key}=${e.value}")
          .join(("&"));
    }
    print(url);
    return client.get(url).then((res) {
      var json = jsonDecode(res.body);
      var code = json["response_code"];
      if (code is int) {
        print(responseCodes[code]);
      }
      print(jsonDecode(res.body));
      return transform(jsonDecode(utf8.decode(res.bodyBytes)));
    });
  }
}
