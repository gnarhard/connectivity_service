import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:connectivity_service/connectivity_service.dart';
import 'package:flutter/material.dart';
import 'package:test/test.dart';

void main() {
  setUp(() => WidgetsFlutterBinding.ensureInitialized());
  test('connection state returns false', () {
    // arrange
    final service = ConnectivityService();

    // act
    service.init();

    // assert
    expect(service.hasConnectivity, false);
  });

  test('connection state returns true', () {
    // arrange
    final service = ConnectivityService();

    // act
    service.init();
    service.state$.add(ConnectivityResult.wifi);

    // assert
    expectLater(service.state$.stream, emits(ConnectivityResult.wifi));
    expect(service.hasConnectivity, true);
  });
}
