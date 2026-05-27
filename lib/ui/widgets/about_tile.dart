import 'package:flutter/material.dart';
import 'package:flutter_uikit/utils/uidata.dart';

class MyAboutTile extends StatelessWidget {
  const MyAboutTile({super.key});

  @override
  Widget build(BuildContext context) {
    return AboutListTile(
      applicationIcon: const FlutterLogo(),
      icon: const FlutterLogo(),
      aboutBoxChildren: <Widget>[
        SizedBox(
          height: 10.0,
        ),
        Text(
          "Developed By Pawan Kumar",
        ),
        Text(
          "MTechViral",
        ),
      ],
      applicationName: UIData.appName,
      applicationVersion: "1.0.1",
      applicationLegalese: "Apache License 2.0",
    );
  }
}
