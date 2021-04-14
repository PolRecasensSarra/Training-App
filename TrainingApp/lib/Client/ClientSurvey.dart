import 'package:flutter/material.dart';

class ClientSurveyPage extends StatefulWidget {
  @override
  _ClientSurveyPageState createState() => _ClientSurveyPageState();
}

class _ClientSurveyPageState extends State<ClientSurveyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Survey"),
      ),
      body: Center(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 20, bottom: 20, left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ElevatedButton(
                child: Text("ENTER"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
