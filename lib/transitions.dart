import 'package:flutter/material.dart';

class FadeSlidePageRoute extends PageRouteBuilder {
  final Widget page;

  FadeSlidePageRoute({required this.page})
      : super(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const beginOffset = Offset(0, 0.1); // slight slide from bottom
      const endOffset = Offset.zero;
      const curve = Curves.easeOut;

      final tween = Tween(begin: beginOffset, end: endOffset).chain(CurveTween(curve: curve));
      final fadeAnimation = CurvedAnimation(parent: animation, curve: curve);

      return SlideTransition(
        position: animation.drive(tween),
        child: FadeTransition(
          opacity: fadeAnimation,
          child: child,
        ),
      );
    },
  );
}