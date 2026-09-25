import 'package:ecommerce_app/core/networking/cubit/network_cubit.dart';
import 'package:ecommerce_app/core/networking/cubit/network_state.dart';
import 'package:ecommerce_app/core/routing/app_routes.dart';
import 'package:ecommerce_app/core/utils/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NetworkListenerWrapper extends StatefulWidget {
  final Widget child;

  const NetworkListenerWrapper({super.key, required this.child});

  @override
  State<NetworkListenerWrapper> createState() => _NetworkListenerWrapperState();
}

class _NetworkListenerWrapperState extends State<NetworkListenerWrapper> {
  bool _isIntialEmit = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: sl<NetworkCubit>(),
      child: BlocListener<NetworkCubit, NetworkState>(
        listener: (context, state) {
          if (_isIntialEmit) {
            _isIntialEmit = true;
            return;
          }
          WidgetsBinding.instance.addPostFrameCallback((_) {
            final messenger = AppRoutes.scaffoldMessengerKey.currentState;
            if (messenger == null) return;

            if (state is NetworkDisconnectedState) {
              AppRoutes.scaffoldMessengerKey.currentState
                  ?.hideCurrentSnackBar();
              AppRoutes.scaffoldMessengerKey.currentState?.showSnackBar(
                const SnackBar(
                  content: Row(
                    children: [
                      Icon(Icons.wifi_off_rounded, color: Colors.white),
                      SizedBox(width: 10),
                      Text(
                        'No Internet Connection',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  backgroundColor: Colors.redAccent,
                  duration: Duration(days: 1),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            } else if (state is NetworkConnectedState) {
              AppRoutes.scaffoldMessengerKey.currentState
                  ?.hideCurrentSnackBar();
              AppRoutes.scaffoldMessengerKey.currentState?.showSnackBar(
                const SnackBar(
                  content: Row(
                    children: [
                      Icon(Icons.wifi_rounded, color: Colors.white),
                      SizedBox(width: 10),
                      Text(
                        'Back Online',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  backgroundColor: Colors.green,
                  duration: Duration(seconds: 3),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          });
        },
        child: widget.child,
      ),
    );
  }
}
