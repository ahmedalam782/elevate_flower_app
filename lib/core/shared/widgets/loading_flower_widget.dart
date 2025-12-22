import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

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
          color: Colors.black.withOpacity(0.25),
          alignment: Alignment.center,
          child: Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}

void showOverLayLoading(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.transparent,
    builder: (_) => const FlowerLoadingOverlay(),
  );
}

void hideOverlayLoading(BuildContext context) {
  if (Navigator.of(context, rootNavigator: true).canPop()) {
    Navigator.of(context, rootNavigator: true).pop();
  }
}
