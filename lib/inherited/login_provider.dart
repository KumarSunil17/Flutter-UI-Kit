import 'package:flutter/material.dart';

class LoginProvider extends InheritedWidget {
  final Function validationErrorCallback;

  const LoginProvider({
    super.key,
    required this.validationErrorCallback,
    required super.child,
  });

  static LoginProvider of(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<LoginProvider>();
    assert(provider != null, 'LoginProvider not found in context');
    return provider!;
  }

  @override
  bool updateShouldNotify(LoginProvider oldWidget) =>
      validationErrorCallback != oldWidget.validationErrorCallback;
}
