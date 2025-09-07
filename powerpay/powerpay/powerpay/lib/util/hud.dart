import 'package:flutter/material.dart';

class HUD {
  static final HUD _instance = HUD._internal();
  factory HUD() => _instance;
  HUD._internal();

  OverlayEntry? _overlayEntry;
  bool _isVisible = false;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  void show() {
    if (!_isVisible) {
      _overlayEntry = OverlayEntry(
        builder: (context) => Container(
          color: Colors.black.withOpacity(0.5),
          child: Center(
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                strokeWidth: 10,
              ),
            ),
          ),
        ),
      );
      navigatorKey.currentState?.overlay?.insert(_overlayEntry!);
      _isVisible = true;
    }
  }

  void hide() {
    if (_isVisible) {
      Future.delayed(const Duration(seconds: 3));
      _overlayEntry?.remove();
      _overlayEntry = null;
      _isVisible = false;
    }
  }
}
