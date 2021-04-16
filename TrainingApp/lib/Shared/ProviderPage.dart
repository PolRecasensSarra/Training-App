import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_app/Shared/LoginPage.dart';

class ProviderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);

    if (user == null) {
      return LoginPage();
    } else {
      // return home page, read the user to know what type of user is
    }
  }
}
