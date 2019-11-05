import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/widgets.dart';

class WolClient {
  final String mac;
  final String address;

  WolClient({
    @required this.mac,
    @required this.address,
  });

  Future<bool> wake() {
    return RawDatagramSocket.bind(InternetAddress.anyIPv4, 0).then((socket) {
      socket.broadcastEnabled = true;
      var packet = getMagicMacket(this.mac, "");
      var address = getBroadcastAddress(this.address);
      return socket.send(packet, InternetAddress(address), 9) > 0;
    }).catchError((err) {
      print(err);
      return false;
    });
  }

  String getBroadcastAddress(String address) {
    // Assumes an IP4 address in a /24 network -> send to x.y.z.255
    return address.split(".").asMap().entries.map((entry) {
      return entry.key == 3 ? "255" : entry.value;
    }).join(".");
  }

  Uint8List getMagicMacket(String mac, String pass) {
    List<int> data = [];

    // The Synchronization Stream is defined as 6 bytes of FFh.
    data.addAll([0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF]);

    // The Target MAC block contains 16 duplications of the IEEE address of the target, with no breaks or interruptions.
    var macBytes = getMacBytes(mac);
    if (macBytes.length != 6) {
      throw Exception("Invalid MAC address. $macBytes");
    }
    for (var i = 0; i < 16; i++) {
      data.addAll(macBytes);
    }

    // The Password field is optional, but if present, contains either 4 bytes or 6 bytes
    // TODO: validate password
    if (pass.isNotEmpty) {
      data.addAll(pass.codeUnits);
    }

    return Uint8List.fromList(data);
  }

  List<int> getMacBytes(String macStr) {
    return macStr
        .split(RegExp("([:-])"))
        .where((it) => it.isNotEmpty)
        .map((it) => int.parse(it, radix: 16))
        .toList();
  }
}
