import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/cupertino.dart';

extension ContextSnackBarExtension on BuildContext {
  void showAnimatedSnackBar(
{
    required String message,
    required AnimatedSnackBarType type,
  }) {
    AnimatedSnackBar.material(
      message,
      type: type,
      mobileSnackBarPosition: MobileSnackBarPosition.bottom,
      desktopSnackBarPosition: DesktopSnackBarPosition.topRight,
    ).show(this);
  }
}
