import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart' show BehaviorSubject;

class ConnectivityService {
  ConnectivityService({
    this.overrideConnectivity = false,
    this.overrideConnectivityValue = false,
    this.allowNetworkToggling = false,
  });

  final bool overrideConnectivity;
  final bool overrideConnectivityValue;
  final bool allowNetworkToggling;
  final _connectivity = Connectivity();
  bool listenersEnabled = false;
  int connectivityChanges = 0;

  final state$ = BehaviorSubject<List<ConnectivityResult>>.seeded(
      [ConnectivityResult.none]);

  bool get hasConnectivity => overrideConnectivity
      ? overrideConnectivityValue
      : !state$.value.contains(ConnectivityResult.none);

  void init() {
    _connectivity.onConnectivityChanged
        .distinct()
        .listen((List<ConnectivityResult> connectionStatus) {
      print('Connectivity: $connectionStatus');

      if (connectivityChanges > 2 && !allowNetworkToggling) {
        return;
      }

      state$.add(connectionStatus);

      connectivityChanges++;
    });
  }
}
