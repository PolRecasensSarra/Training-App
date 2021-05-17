import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:training_app/Services/auth.dart';
import 'package:training_app/Services/tools.dart';

import 'Shared/LoginPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.indigo,
        ),
        darkTheme: ThemeData(
          appBarTheme: AppBarTheme(color: Colors.grey[900]),
          brightness: Brightness.dark,
          primarySwatch: Tools().createMaterialColor(Color(0xFF227A73)),
          primaryColor: Colors.deepPurple[300],
        ),
        themeMode: ThemeMode.dark,
        home: LoginPage(),
      ),
    );
  }
}

enum UserType { worker, client, individual, none }
