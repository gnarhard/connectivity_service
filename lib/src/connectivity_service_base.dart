import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:rxdart/rxdart.dart' show BehaviorSubject;

class ConnectivityService {
  final state$ =
      BehaviorSubject<ConnectivityResult>.seeded(ConnectivityResult.none);
  final _connectivity = Connectivity();
  bool listenersEnabled = false;

  bool get hasConnectivity => state$.value != ConnectivityResult.none;

  // Platform messages are asynchronous, so we initialize in an async method.
  void init() {
    _connectivity.onConnectivityChanged
        .distinct()
        .listen((ConnectivityResult connectionStatus) {
      state$.add(connectionStatus);
    });
  }
}
