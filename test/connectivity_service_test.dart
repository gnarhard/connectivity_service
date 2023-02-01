import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:connectivity_service/connectivity_service.dart';
import 'package:flutter/material.dart';
import 'package:test/test.dart';

void main() {
  setUp(() => WidgetsFlutterBinding.ensureInitialized());
  test('connection state returns false', () {
    final service = ConnectivityService();
    expect(service.hasConnectivity, false);
  });

  test('connection state returns true', () {
    final service = ConnectivityService();
    service.state$.add(ConnectivityResult.wifi);
    expectLater(service.state$.stream, emits(ConnectivityResult.wifi));
    expect(service.hasConnectivity, true);
  });
}
