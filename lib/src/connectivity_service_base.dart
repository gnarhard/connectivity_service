import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart' show BehaviorSubject;

class ConnectivityService {
  final _connectivity = Connectivity();
  bool listenersEnabled = false;

  final state$ = BehaviorSubject<List<ConnectivityResult>>.seeded(
      [ConnectivityResult.none]);

  bool get hasConnectivity => !state$.value.contains(ConnectivityResult.none);

  void init() {
    _connectivity.onConnectivityChanged
        .distinct()
        .listen((List<ConnectivityResult> connectionStatus) {
      debugPrint('Connectivity: $connectionStatus');
      state$.add(connectionStatus);
    });
  }
}
