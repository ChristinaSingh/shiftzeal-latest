import 'dart:math';

import 'package:flutter/material.dart';

class NavigationMethods {
  static pushMethod(
      {required BuildContext context,
      required Widget widget,
      bool wantAnimation = true}) {
    Navigator.push(
      context,
      wantAnimation
          ? _createRoute(widget)
          : MaterialPageRoute(builder: (context) => widget),
    );
  }

// List of transition functions
  static List<Function> transitionFunctions = [
    (Animation<double> animation, Widget child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.easeInOut;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);
      return SlideTransition(position: offsetAnimation, child: child);
    },
    (Animation<double> animation, Widget child) {
      const begin = 0.0;
      const end = 1.0;
      const curve = Curves.easeInOut;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var opacityAnimation = animation.drive(tween);
      return FadeTransition(opacity: opacityAnimation, child: child);
    },
    // Add more transitions as needed
  ];

// Create a route with a random transition for each instance
  static Route _createRoute(Widget widget) {
    final random = Random();
    final transitionFunction =
        transitionFunctions[random.nextInt(transitionFunctions.length)];

    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => widget,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return transitionFunction(animation, child) as Widget;
      },
    );
  }

  static pushReplacementMethod(
      {required BuildContext context, required Widget widget}) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
  }

  static pushAndRemoveUntilMethod(
      {required BuildContext context, required Widget widget}) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => widget),
        (Route<dynamic> route) => false);
  }

  static popMethod({required BuildContext context}) {
    Navigator.pop(context);
  }
}
