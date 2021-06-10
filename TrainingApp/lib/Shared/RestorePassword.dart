import 'package:flutter/material.dart';
import 'package:training_app/Services/auth.dart';

class RestorePassword extends StatefulWidget {
  @override
  _RestorePasswordState createState() => _RestorePasswordState();
}

class _RestorePasswordState extends State<RestorePassword> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Restore Password"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                    cursorColor: Colors.white,
                    validator: (val) => val.isEmpty ? "Enter your email" : null,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(8.0), //here your padding
                      fillColor: Colors.grey[800],
                      filled: true,
                      hintText: 'Email',
                      helperText:
                          "enter the email you want to recover the password from",
                      helperMaxLines: 3,
                      prefixIcon: Icon(
                        Icons.email,
                        color: Colors.white,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(color: Colors.grey[700]),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(color: Colors.grey[800]),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(color: Colors.grey[800]),
                      ),
                    ),
                    onChanged: (val) {
                      email = val;
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    child: Text("Send Request"),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _auth.sendPasswordResetEmail(email);
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
