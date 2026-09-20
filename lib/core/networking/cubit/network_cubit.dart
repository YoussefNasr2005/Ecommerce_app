import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ecommerce_app/core/networking/cubit/network_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NetworkCubit extends Cubit<NetworkState> {
  final Connectivity _connectivity;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;

  NetworkCubit({Connectivity? connectivity})
      : _connectivity = connectivity ?? Connectivity(),
        super(const NetworkInitialState()) {
    _monitorConnectivity();
  }

  void _monitorConnectivity() {
    _connectivitySubscription = _connectivity.onConnectivityChanged
        .listen((result) => _checkStatus(result));
  }

  void _checkStatus(List<ConnectivityResult> result) {
    (result.contains(ConnectivityResult.none) || result.isEmpty)
        ? emit(const NetworkDisconnectedState())
        : emit(const NetworkConnectedState());
  }

  @override
  Future<void> close() {
    _connectivitySubscription?.cancel();
    return super.close();
  }


}
