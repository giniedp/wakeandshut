import 'dart:typed_data';
import 'package:flutter/services.dart';

class ServiceInfo {
  static final jsonName = 'name';
  static final jsonType = 'type';
  static final jsonHostName = 'hostName';
  static final jsonAddress = 'address';
  static final jsonPort = 'port';
  static final jsonAttr = 'attr';

  Map<String, Uint8List> attr;
  String name;
  String type;
  String hostName;
  String address;
  int port;
  ServiceInfo(
      this.attr, this.name, this.type, this.hostName, this.address, this.port);

  static ServiceInfo fromMap(Map fromChannel) {
    Map<String, Uint8List> attr;
    String name = "";
    String type = "";
    String hostName = "";
    String address = "";
    int port = 0;

    if (fromChannel.containsKey(jsonAttr)) {
      attr = Map<String, Uint8List>.from(fromChannel[jsonAttr]);
    }

    if (fromChannel.containsKey(jsonName)) {
      name = fromChannel[jsonName];
    }

    if (fromChannel.containsKey(jsonType)) {
      type = fromChannel[jsonType];
    }

    if (fromChannel.containsKey(jsonHostName)) {
      hostName = fromChannel[jsonHostName];
    }

    if (fromChannel.containsKey(jsonAddress)) {
      address = fromChannel[jsonAddress];
    }

    if (fromChannel.containsKey(jsonPort)) {
      port = fromChannel[jsonPort];
    }

    return new ServiceInfo(attr, name, type, hostName, address, port);
  }

  @override
  String toString() {
    return "Name: $name, Type: $type, HostName: $hostName, Address: $address, Port: $port";
  }

  Map<String, dynamic> toMap({List<String> exclude}) {
    return {
      jsonName: name,
      jsonType: type,
      jsonHostName: hostName,
      jsonAddress: address,
      jsonPort: port,
      jsonAttr: attr,
    };
  }
}

typedef void ServiceInfoCallback(ServiceInfo info);

typedef void IntCallback(int data);
typedef void VoidCallback();

class DiscoveryCallbacks {
  VoidCallback onDiscoveryStarted;
  VoidCallback onDiscoveryStopped;
  ServiceInfoCallback onDiscovered;
  ServiceInfoCallback onResolved;
  ServiceInfoCallback onLost;
  DiscoveryCallbacks({
    this.onDiscoveryStarted,
    this.onDiscoveryStopped,
    this.onDiscovered,
    this.onResolved,
    this.onLost,
  });
}

class FlutterMdnsPlugin {
  static const String NAMESPACE = "eu.sndr.mdns";

  String _serviceType;

  static const MethodChannel _channel =
      const MethodChannel('flutter_mdns_plugin');

  final EventChannel _serviceDiscoveredChannel =
      const EventChannel("$NAMESPACE/discovered");

  final EventChannel _serviceResolvedChannel =
      const EventChannel("$NAMESPACE/resolved");

  final EventChannel _serviceLostChannel =
      const EventChannel("$NAMESPACE/lost");

  final EventChannel _discoveryRunningChannel =
      const EventChannel("$NAMESPACE/running");

  DiscoveryCallbacks discoveryCallbacks;

  FlutterMdnsPlugin({this.discoveryCallbacks}) {
    if (discoveryCallbacks != null) {
      //Configure all the discovery related callbacks and event channels
      _serviceResolvedChannel.receiveBroadcastStream().listen((data) {
        print("Service resolved ${data.toString()}");
        discoveryCallbacks.onResolved(ServiceInfo.fromMap(data));
      });

      _serviceDiscoveredChannel.receiveBroadcastStream().listen((data) {
        print("Service discovered ${data.toString()}");
        discoveryCallbacks.onDiscovered(ServiceInfo.fromMap(data));
      });

      _serviceLostChannel.receiveBroadcastStream().listen((data) {
        print("Service lost ${data.toString()}");
        discoveryCallbacks.onLost(ServiceInfo.fromMap(data));
      });

      _discoveryRunningChannel.receiveBroadcastStream().listen((running) {
        print("Discovery Running? $running");
        if (running && discoveryCallbacks.onDiscoveryStarted != null) {
          discoveryCallbacks.onDiscoveryStarted();
        } else if (discoveryCallbacks.onDiscoveryStopped != null) {
          discoveryCallbacks.onDiscoveryStopped();
        }
      });
    }
  }

  startDiscovery(String serviceType) {
    _serviceType = serviceType;
    Map args = new Map();
    args["serviceType"] = _serviceType;
    _channel.invokeMethod("startDiscovery", args);
  }

  stopDiscovery() {
    _channel.invokeMethod("stopDiscovery", new Map());
  }

  restartDiscovery() {
    stopDiscovery();
    startDiscovery(_serviceType);
  }
}
