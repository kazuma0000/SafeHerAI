import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

abstract class ConnectivityMonitor {
  Stream<bool> get online;
  Future<bool> get isOnline;
}

class ConnectivityService implements ConnectivityMonitor {
  final Connectivity _connectivity;
  ConnectivityService([Connectivity? connectivity]) : _connectivity = connectivity ?? Connectivity();
  @override
  Stream<bool> get online => _connectivity.onConnectivityChanged.map((results) => results.any((r) => r != ConnectivityResult.none));
  @override
  Future<bool> get isOnline async => (await _connectivity.checkConnectivity()).any((r) => r != ConnectivityResult.none);
}
