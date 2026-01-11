import 'package:flutter/material.dart';

final class AppHelper {
  static void showAnimationDialog({
    required Widget child,
    required BuildContext context,
    bool? barrierDismissible,
  }) {
    showGeneralDialog(
      context: context,
      barrierDismissible: barrierDismissible ?? true,
      barrierLabel: '',
      transitionDuration: Duration(milliseconds: 400),
      pageBuilder: (context, animation, secondaryAnimation) {
        return SizedBox.shrink();
      },
      transitionBuilder: (context, a1, a2, widget) => Align(
        alignment: Alignment.center,
        child: Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
