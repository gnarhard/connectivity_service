import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart' show BehaviorSubject;

class ConnectivityService {
  ConnectivityService({this.overrideConnectivity = false, this.overrideConnectivityValue = false});

  final bool overrideConnectivity;
  final bool overrideConnectivityValue;
  final _connectivity = Connectivity();
  bool listenersEnabled = false;

  final state$ = BehaviorSubject<List<ConnectivityResult>>.seeded(
      [ConnectivityResult.none]);

  bool get hasConnectivity => overrideConnectivity ? overrideConnectivityValue : !state$.value.contains(ConnectivityResult.none);

  void init() {
    _connectivity.onConnectivityChanged
        .distinct()
        .listen((List<ConnectivityResult> connectionStatus) {
      debugPrint('Connectivity: $connectionStatus');
      state$.add(connectionStatus);
    });
  }
}
