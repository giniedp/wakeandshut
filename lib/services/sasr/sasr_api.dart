import 'package:flutter_mdns_plugin/flutter_mdns_plugin.dart';
import 'package:http/http.dart' as http;

class SasrApi {
  final ServiceInfo info;

  SasrApi({this.info});

  String get _baseUrl {
    return "http://${info.address}:${info.port}";
  }

  Future<bool> shutdown() async {
    var result = await http.post("$_baseUrl/shutdown");
    return result.statusCode >= 200 && result.statusCode < 300;
  }

  Future<bool> reboot() async {
    var result = await http.post("$_baseUrl/reboot");
    return result.statusCode >= 200 && result.statusCode < 300;
  }

  Future<bool> hibernate() async {
    var result = await http.post("$_baseUrl/hibernate");
    return result.statusCode >= 200 && result.statusCode < 300;
  }

  Future<bool> status() async {
    var result = await http.get("$_baseUrl/status");
    return result.statusCode >= 200 && result.statusCode < 300;
  }
}
