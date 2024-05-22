import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart' show BehaviorSubject;

class ConnectivityService {
  ConnectivityService({this.overrideConnectivity = false});

  final bool overrideConnectivity;
  final _connectivity = Connectivity();
  bool listenersEnabled = false;

  final state$ = BehaviorSubject<List<ConnectivityResult>>.seeded(
      [ConnectivityResult.none]);

  bool get hasConnectivity => overrideConnectivity ? true : !state$.value.contains(ConnectivityResult.none);

  void init() {
    _connectivity.onConnectivityChanged
        .distinct()
        .listen((List<ConnectivityResult> connectionStatus) {
      debugPrint('Connectivity: $connectionStatus');
      state$.add(connectionStatus);
    });
  }
}
