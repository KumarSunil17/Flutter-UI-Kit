import 'package:flutter/material.dart';

class CommonDivider extends StatelessWidget {
  const CommonDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: Colors.grey.shade300,
      height: 8.0,
    );
  }
}
