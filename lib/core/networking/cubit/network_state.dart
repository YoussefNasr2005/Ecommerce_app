import 'package:equatable/equatable.dart';

abstract class NetworkState extends Equatable {
  const NetworkState();

  @override
  List<Object?> get props => [];
}

class NetworkInitialState extends NetworkState {
  const NetworkInitialState();
}

class NetworkConnectedState extends NetworkState {
  const NetworkConnectedState();
}

class NetworkDisconnectedState extends NetworkState {
  const NetworkDisconnectedState();
}
