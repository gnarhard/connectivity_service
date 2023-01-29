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
}
