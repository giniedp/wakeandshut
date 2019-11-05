import 'package:flutter_mdns_plugin/flutter_mdns_plugin.dart';
import 'dart:async';
import 'discovery_list.dart';
import 'discovery_log.dart';

class Discovery {
  FlutterMdnsPlugin _mdnsPlugin;
  final DiscoveryLog logger = DiscoveryLog();
  final DiscoveryList services = DiscoveryList();

  DiscoveryCallbacks _discoveryCallbacks;

  final String _serviceType = "_http._tcp.";

  Discovery() {
    _discoveryCallbacks =
        new DiscoveryCallbacks(onDiscovered: (ServiceInfo info) {
      logger.write("Discovered ${info.toString()}");
      services.put(info);
    }, onDiscoveryStarted: () {
      logger.write("Started");
      services.clear();
    }, onDiscoveryStopped: () {
      logger.write("Stopped");
    }, onResolved: (ServiceInfo info) {
      logger.write("Resolved ${info.toString()}");
      services.put(info);
    }, onLost: (ServiceInfo info) {
      logger.write("Lost ${info.toString()}");
      services.delete(info);
    });
  }

  start() {
    if (_mdnsPlugin == null) {
      _mdnsPlugin =
          new FlutterMdnsPlugin(discoveryCallbacks: _discoveryCallbacks);
      Timer(Duration(seconds: 3), () {
        if (_mdnsPlugin != null) {
          logger.write("Starting mDNS for service type [$_serviceType]");
          _mdnsPlugin.startDiscovery(_serviceType);
        }
      });
    } else {
      _mdnsPlugin.restartDiscovery();
    }
  }

  stop() {
    if (_mdnsPlugin != null) {
      _mdnsPlugin.stopDiscovery();
    }
  }
}
