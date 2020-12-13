import 'package:flutter/material.dart';
import 'package:flutter_sheplates/Utils/Routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sheplates',
      initialRoute: Routes.initialRoute,
      onGenerateRoute: Routes.generateRoute,
      theme: ThemeData(
        fontFamily: "Ubuntu",
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
