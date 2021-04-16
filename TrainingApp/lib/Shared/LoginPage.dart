import 'package:training_app/main.dart';
import 'package:flutter/material.dart';
import '../Worker/HomeWorkerPage.dart';
import '../Client/HomeClientPage.dart';
import '../Individual/HomeIndividualPage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Item dropdownValue;
  int _selectedIndex = 0;

  List<Item> users = <Item>[
    const Item("Worker"),
    const Item("Client"),
    const Item("Individual"),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Login Page",
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            label: "Sign In",
            icon: Icon(Icons.login),
          ),
          BottomNavigationBarItem(
            label: "Sign Up",
            icon: Icon(Icons.app_registration),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.orangeAccent[700],
        onTap: _onItemTapped,
      ),
      body: toggleSignInSignUp(_selectedIndex),
    );
  }

  toggleSignInSignUp(int index) {
    if (index == 0) {
      return Center(
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
                      builder: (context) => HomeWorkerPage(
                        userType: UserType.worker,
                      ),
                    ),
                  );
                } else if (dropdownValue.type == "Client") {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => HomeClientPage(
                        userType: UserType.client,
                      ),
                    ),
                  );
                } else if (dropdownValue.type == "Individual") {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => HomeIndividualPage(
                        userType: UserType.individual,
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      );
    } else {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Sign Up"),
          ],
        ),
      );
    }
  }
}

class Item {
  const Item(this.type);
  final String type;
}
