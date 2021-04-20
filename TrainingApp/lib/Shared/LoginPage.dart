import 'package:training_app/Services/auth.dart';
import 'package:flutter/material.dart';
import 'package:training_app/Shared/Loading.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Item dropdownValue;
  int _selectedIndex = 0;
  List<String> _titleList = ["Sign in to App", "Register to App"];

  final _formKey = GlobalKey<FormState>();

  final AuthService _auth = AuthService();
  bool loading = false;
  //Text field states
  String email = "";
  String password = "";
  String referral = "";
  String username = "";
  String error = "";

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
    return loading
        ? Loading()
        : Scaffold(
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
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
          child: ListView(
            children: [
              Form(
                key: _formKey,
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
                      validator: (val) => val.isEmpty ? "Enter an email" : null,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        icon: Icon(
                          Icons.email,
                        ),
                      ),
                      onChanged: (val) {
                        email = val;
                      },
                    ),
                    SizedBox(
                      height: 50.0,
                    ),
                    TextFormField(
                      validator: (val) =>
                          val.isEmpty ? "Enter a password" : null,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'password',
                        icon: Icon(Icons.lock),
                      ),
                      onChanged: (val) {
                        password = val;
                      },
                    ),
                    SizedBox(
                      height: 50.0,
                    ),
                    ElevatedButton(
                      child: Text("Sign In"),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() => loading = true);
                          dynamic result = await _auth
                              .signInWithEmailAndPassword(email, password);
                          if (result == null) {
                            setState(() {
                              error = "Email or password incorrect";
                              loading = false;
                            });
                          }
                        }
                      },
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    Text(
                      error,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 14,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      //------------------------------ REGISTER---------------------
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
          child: ListView(
            children: [
              Form(
                key: _formKey,
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
                      height: 30.0,
                    ),
                    userContainer(), // ALL THE STUFF FOR EVERY USER
                    SizedBox(
                      height: 50.0,
                    ),
                    ElevatedButton(
                      //TODO: canviar això pel logIn de firebase
                      child: Text("Register"),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() => loading = true);
                          dynamic result =
                              await _auth.registerWithEmailAndPassword(email,
                                  password, username, dropdownValue.type);
                          if (result == null) {
                            setState(() {
                              error = "Invalid email or username already taken";
                              loading = false;
                            });
                          }
                        }
                      },
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    Text(
                      error,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
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
              hintText: 'Enter your Username',
              icon: Icon(
                Icons.person,
              ),
            ),
            validator: (val) => val.isEmpty
                ? "Enter a username"
                : null, //TODO: mirar que no existeixi ja aquest nom d'usuari
            onChanged: (val) {
              setState(() {
                username = val;
              });
            },
          ),
          SizedBox(
            height: 30.0,
          ),
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Enter your Email',
              icon: Icon(
                Icons.email,
              ),
            ),
            validator: (val) => val.isEmpty ? "Enter an email" : null,
            onChanged: (val) {
              setState(() {
                email = val;
              });
            },
          ),
          SizedBox(
            height: 30.0,
          ),
          TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'Enter your password',
              icon: Icon(Icons.lock),
            ),
            validator: (val) =>
                val.length < 6 ? "Enter a password 6+ characters long" : null,
            onChanged: (val) {
              setState(() {
                password = val;
              });
            },
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
              hintText: 'Enter your Username',
              icon: Icon(
                Icons.person,
              ),
            ),
            validator: (val) => val.isEmpty
                ? "Enter a username"
                : null, //TODO: mirar que no existeixi ja aquest nom d'usuari
            onChanged: (val) {
              setState(() {
                username = val;
              });
            },
          ),
          SizedBox(
            height: 30.0,
          ),
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Enter your Email',
              icon: Icon(
                Icons.email,
              ),
            ),
            validator: (val) => val.isEmpty ? "Enter an email" : null,
            onChanged: (val) {
              setState(() {
                email = val;
              });
            },
          ),
          SizedBox(
            height: 30.0,
          ),
          TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'Enter your password',
              icon: Icon(Icons.lock),
            ),
            validator: (val) =>
                val.length < 6 ? "Enter a password 6+ characters long" : null,
            onChanged: (val) {
              setState(() {
                password = val;
              });
            },
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
              hintText: 'Enter your Username',
              icon: Icon(
                Icons.person,
              ),
            ),
            validator: (val) => val.isEmpty
                ? "Enter a username"
                : null, //TODO: mirar que no existeixi ja aquest nom d'usuari
            onChanged: (val) {
              setState(() {
                username = val;
              });
            },
          ),
          SizedBox(
            height: 30.0,
          ),
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Enter your Email',
              icon: Icon(
                Icons.email,
              ),
            ),
            validator: (val) => val.isEmpty ? "Enter an email" : null,
            onChanged: (val) {
              setState(() {
                email = val;
              });
            },
          ),
          SizedBox(
            height: 30.0,
          ),
          TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'Enter your password',
              icon: Icon(Icons.lock),
            ),
            validator: (val) =>
                val.length < 6 ? "Enter a password 6+ characters long" : null,
            onChanged: (val) {
              setState(() {
                password = val;
              });
            },
          ),
          SizedBox(
            height: 30.0,
          ),
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Enter referral code',
              icon: Icon(Icons.animation),
            ),
            validator: (val) => val.isEmpty ? "Enter a referral code" : null,
            onChanged: (val) {
              setState(() {
                referral = val;
              });
            },
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
