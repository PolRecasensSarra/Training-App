import 'package:flutter/material.dart';
import 'Shared/LoginPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.pinkAccent[300],
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.indigo,
        primaryColor: Colors.indigo,
      ),
      themeMode: ThemeMode.dark,
      home: LoginPage(),
    );
  }
}

enum UserType { worker, client, individual }
