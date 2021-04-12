import 'package:flutter/material.dart';

class CreateSurveyPage extends StatefulWidget {
  @override
  _CreateSurveyPageState createState() => _CreateSurveyPageState();
}

class _CreateSurveyPageState extends State<CreateSurveyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Survey"),
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
