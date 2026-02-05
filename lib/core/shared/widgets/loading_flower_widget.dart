import 'dart:ui';
import '../../routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../theme/app_animations.dart';

class FlowerLoadingOverlay extends StatelessWidget {
  const FlowerLoadingOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.black.withValues(alpha: 0.25),
          alignment: Alignment.center,
          child: Lottie.asset(
            AppAnimations.animationsLoadingAnimation,
            width: 200,
            height: 200,
          ),
        ),
      ),
    );
  }
}

void showOverLayLoading() {
  if (navigatorKey.currentContext == null) return;
  showDialog(
    context: navigatorKey.currentContext!,
    barrierDismissible: false,
    barrierColor: Colors.transparent,
    builder: (_) => const FlowerLoadingOverlay(),
  );
}

void hideOverlayLoading() {
  if (navigatorKey.currentContext == null) return;
  if (Navigator.of(
    navigatorKey.currentContext!,
    rootNavigator: true,
  ).canPop()) {
    Navigator.of(navigatorKey.currentContext!, rootNavigator: true).pop();
  }
}
