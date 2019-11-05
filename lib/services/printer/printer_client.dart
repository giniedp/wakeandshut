import 'package:flutter_mdns_plugin/flutter_mdns_plugin.dart';
import 'package:url_launcher/url_launcher.dart';

class PrinterClient {
  final ServiceInfo info;

  PrinterClient({this.info});

  Future<bool> openInBrowser() async {
    var url = "http://${info.address}";
    if (await canLaunch(url)) {
      launch(url);
      return true;
    }
    return false;
  }
}
