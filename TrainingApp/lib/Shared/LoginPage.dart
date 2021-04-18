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
  List<String> _titleList = ["Sign in to App", "Register to App"];

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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          _titleList[_selectedIndex],
        ),
        actions: <Widget>[
          Image.network(
              "https://raw.githubusercontent.com/PolRecasensSarra/Training-App/main/Assets/logo.png")
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[800],
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
        onTap: _onItemTapped,
      ),
      body: toggleSignInSignUp(_selectedIndex),
    );
  }

  toggleSignInSignUp(int index) {
    if (index == 0) {
      //------------------------------ LOGIN---------------------
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 40),
          child: Form(
            child: Column(
              children: [
                Text(
                  "Training App",
                  style: TextStyle(
                    fontSize: 28,
                  ),
                ),
                SizedBox(
                  height: 70.0,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Email',
                    icon: Icon(
                      Icons.email,
                    ),
                  ),
                  onChanged: (val) {},
                ),
                SizedBox(
                  height: 50.0,
                ),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'password',
                    icon: Icon(Icons.lock),
                  ),
                  onChanged: (val) {},
                ),
                SizedBox(
                  height: 50.0,
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                      //TODO: canviar això pel logIn de firebase
                      child: Text("Sign In"),
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      //------------------------------ REGISTER---------------------
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 40),
          child: Form(
            child: Column(
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
                  style: const TextStyle(fontSize: 18),
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
                  height: 50.0,
                ),
                userContainer(),
              ],
            ),
          ),
        ),
      );
    }
  }

  userContainer() {
    if (dropdownValue == null) {
      return Text("Please, select what type of user you are");
    }
    //----------------WORKER------------------
    else if (dropdownValue.type == "Worker") {
      return Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Enter your Email',
              icon: Icon(
                Icons.email,
              ),
            ),
            onChanged: (val) {},
          ),
          SizedBox(
            height: 50.0,
          ),
          TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'Enter your password',
              icon: Icon(Icons.lock),
            ),
            onChanged: (val) {},
          ),
          SizedBox(
            height: 50.0,
          ),
          ElevatedButton(
            //TODO: canviar això pel logIn de firebase
            child: Text("Sign In"),
            onPressed: () {},
          ),
        ],
      );
    }
    //----------------INDIVIDUAL------------------
    else if (dropdownValue.type == "Individual") {
      return Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Enter your Email',
              icon: Icon(
                Icons.email,
              ),
            ),
            onChanged: (val) {},
          ),
          SizedBox(
            height: 50.0,
          ),
          TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'Enter your password',
              icon: Icon(Icons.lock),
            ),
            onChanged: (val) {},
          ),
          SizedBox(
            height: 50.0,
          ),
          ElevatedButton(
            //TODO: canviar això pel logIn de firebase
            child: Text("Sign In"),
            onPressed: () {},
          ),
        ],
      );
    }
    //----------------CLIENT------------------
    else if (dropdownValue.type == "Client") {
      return Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Enter your Email',
              icon: Icon(
                Icons.email,
              ),
            ),
            onChanged: (val) {},
          ),
          SizedBox(
            height: 50.0,
          ),
          TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'Enter your password',
              icon: Icon(Icons.lock),
            ),
            onChanged: (val) {},
          ),
          SizedBox(
            height: 50.0,
          ),
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Enter referral code',
              icon: Icon(Icons.animation),
            ),
            onChanged: (val) {},
          ),
          SizedBox(
            height: 50.0,
          ),
          ElevatedButton(
            //TODO: canviar això pel logIn de firebase
            child: Text("Sign In"),
            onPressed: () {},
          ),
        ],
      );
    }
  }
}

class Item {
  const Item(this.type);
  final String type;
}
