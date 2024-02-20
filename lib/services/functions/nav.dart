import 'package:flutter/material.dart';

class NavigationServices {
  Route createRoute(Widget newRoute, bool fromBottom) {
    return PageRouteBuilder(
      transitionDuration: Duration(milliseconds: fromBottom ? 500 : 300),
      pageBuilder: (context, animation, secondaryAnimation) => newRoute,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = fromBottom
            ? const Offset(0.0, 1.0)
            : const Offset(1.0, 0.0);
        var end = Offset.zero;
        var curve = fromBottom
            ? Curves.easeInOut
            : Curves.easeOut;
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }

  void pushScreen(BuildContext context, {
    required Widget screen,
    bool fromBottom = false,
  }) {
    Navigator.of(context).push(createRoute(screen, fromBottom));
  }

  void pop(BuildContext context) {
    Navigator.of(context).pop();
  }

  void popAll(BuildContext context) {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  /// Use [replaceScreen] to navigate to a new screen and
  /// discarding the Navigator stack
  void replaceScreen(BuildContext context, {
    required Widget screen,
    bool fromBottom = false,
  }) {
    Navigator.of(context).pushReplacement(createRoute(screen, fromBottom));
  }
}
