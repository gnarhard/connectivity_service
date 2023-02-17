import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart' show BehaviorSubject;

class ConnectivityService {
  final _connectivity = Connectivity();
  bool listenersEnabled = false;

  final state$ =
      BehaviorSubject<ConnectivityResult>.seeded(ConnectivityResult.none);

  bool get hasConnectivity => state$.value != ConnectivityResult.none;

  init() {
    _connectivity.onConnectivityChanged
        .distinct()
        .listen((ConnectivityResult connectionStatus) {
      debugPrint('Connectivity: $connectionStatus');
      state$.add(connectionStatus);
    });
  }
}
