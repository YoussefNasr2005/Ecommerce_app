import 'package:ecommerce_app/core/networking/cubit/network_cubit.dart';
import 'package:ecommerce_app/core/networking/cubit/network_state.dart';
import 'package:ecommerce_app/core/utils/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NetworkListenerWrapper extends StatelessWidget {
  final Widget child;

  const NetworkListenerWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: sl<NetworkCubit>(),
      child: BlocListener<NetworkCubit, NetworkState>(
        listener: (context, state) {
          if (state is NetworkDisconnectedState) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Row(
                  children: [
                    Icon(Icons.wifi_off_rounded, color: Colors.white),
                    SizedBox(width: 10),
                    Text(
                      'No Internet Connection',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                backgroundColor: Colors.redAccent,
                duration: Duration(days: 1),
                behavior: SnackBarBehavior.floating,
              ),
            );
          } else if (state is NetworkConnectedState) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Row(
                  children: [
                    Icon(Icons.wifi_rounded, color: Colors.white),
                    SizedBox(width: 10),
                    Text(
                      'Back Online',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                backgroundColor: Colors.green,
                duration: Duration(seconds: 3),
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        child: child,
      ),
    );
  }
}
