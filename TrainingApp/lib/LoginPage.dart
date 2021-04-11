import 'package:TrainingApp/main.dart';
import 'package:flutter/material.dart';
import 'HomePage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Item dropdownValue;

  List<Item> users = <Item>[
    const Item("Worker"),
    const Item("Client"),
    const Item("Individual"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Login Page",
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton<Item>(
              hint: Text("Select user"),
              value: dropdownValue,
              icon: const Icon(
                Icons.arrow_downward,
                color: Colors.white,
              ),
              iconSize: 24,
              elevation: 16,
              style: const TextStyle(color: Colors.white),
              underline: Container(
                height: 2,
                color: Colors.white,
              ),
              onChanged: (newValue) {
                setState(() {
                  dropdownValue = newValue;
                });
              },
              items: users.map((Item user) {
                return DropdownMenuItem<Item>(
                  value: user,
                  child: Text(user.type),
                );
              }).toList(),
            ),
            SizedBox(
              width: 200.0,
              height: 100.0,
            ),
            ElevatedButton(
              child: Text("Go To Home"),
              onPressed: () {
                if (dropdownValue == null) return;
                if (dropdownValue.type == "Worker") {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => HomePage(
                        userType: UserType.worker,
                      ),
                    ),
                  );
                } else if (dropdownValue.type == "Client") {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => HomePage(
                        userType: UserType.client,
                      ),
                    ),
                  );
                } else if (dropdownValue.type == "Individual") {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => HomePage(
                        userType: UserType.individual,
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Item {
  const Item(this.type);
  final String type;
}
