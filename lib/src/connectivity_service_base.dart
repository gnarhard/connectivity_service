import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:rxdart/rxdart.dart' show BehaviorSubject;

class ConnectivityService {
  final bool overrideConnectivity;
  final bool overrideConnectivityValue;
  final bool allowNetworkToggling;

  ConnectivityService({
    this.overrideConnectivity = false,
    this.overrideConnectivityValue = false,
    this.allowNetworkToggling = true,
  });

  final _connectivity = Connectivity();
  bool disableFutureConnections = false;

  final state$ = BehaviorSubject<List<ConnectivityResult>>.seeded([]);

  bool get hasConnectivity => overrideConnectivity
      ? overrideConnectivityValue
      : !state$.value.contains(ConnectivityResult.none);

  void init() {
    _connectivity.onConnectivityChanged
        .listen((List<ConnectivityResult> connectionStatus) {
      // allow toggling from network to none, but not none to network

      if (disableFutureConnections && !allowNetworkToggling) {
        if (connectionStatus.contains(ConnectivityResult.wifi)) {
          return;
        }
      }

      state$.add(connectionStatus);
      print('Connectivity: $connectionStatus');
    });

    Timer(const Duration(seconds: 2), () {
      if (state$.value.contains(ConnectivityResult.none)) {
        disableFutureConnections = true;
      }
    });
  }
}
