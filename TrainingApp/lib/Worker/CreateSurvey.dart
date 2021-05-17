import 'package:flutter/material.dart';
import 'package:training_app/Services/tools.dart';

class CreateSurveyPage extends StatefulWidget {
  @override
  _CreateSurveyPageState createState() => _CreateSurveyPageState();
}

class _CreateSurveyPageState extends State<CreateSurveyPage> {
  final _formKey = GlobalKey<FormState>();
  String pathSurvey = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Survey"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 60,
            bottom: 20,
            left: 38,
            right: 38,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Form(
                key: _formKey,
                child: TextFormField(
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[800],
                    prefixIcon: Icon(
                      Icons.poll,
                      color: Colors.white,
                    ),
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 16),
                    contentPadding: EdgeInsets.all(8.0), //here your padding
                    hintText: 'Enter a survey URL',
                    helperText:
                        "Please, provide an URL to a Survey.\nYou can use Google Forms to create a quick survey.",
                    helperMaxLines: 6,
                    hintStyle: TextStyle(fontSize: 12),
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
                    setState(() {
                      pathSurvey = val;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          child: Text("Go to Google Forms"),
                          onPressed: () {
                            Tools()
                                .customLaunch("https://docs.google.com/forms");
                          },
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          child: Text("SAVE"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
