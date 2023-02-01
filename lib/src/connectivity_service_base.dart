import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:rxdart/rxdart.dart' show BehaviorSubject;

class ConnectivityService {
  final _connectivity = Connectivity();
  bool listenersEnabled = false;

  final state$ =
      BehaviorSubject<ConnectivityResult>.seeded(ConnectivityResult.none);

  bool get hasConnectivity => state$.value != ConnectivityResult.none;

  ConnectivityService() {
    _connectivity.onConnectivityChanged
        .distinct()
        .listen((ConnectivityResult connectionStatus) {
      state$.add(connectionStatus);
    });
  }
}
