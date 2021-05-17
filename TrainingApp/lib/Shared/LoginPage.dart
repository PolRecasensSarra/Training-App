import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:training_app/Client/HomeClientPage.dart';
import 'package:training_app/Individual/HomeIndividualPage.dart';
import 'package:training_app/Services/Database.dart';
import 'package:training_app/Services/auth.dart';
import 'package:flutter/material.dart';
import 'package:training_app/Shared/Loading.dart';
import 'package:training_app/Worker/HomeWorkerPage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Item dropdownValue;
  int _selectedIndex = 0;
  List<String> _titleList = ["Sign in", "Register"];

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
      error = "";
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              bottomNavigationBar: BottomNavigationBar(
                selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
                selectedItemColor: Colors.tealAccent,
                backgroundColor: Colors.grey[800],
                items: [
                  BottomNavigationBarItem(
                    label: "Sign In",
                    icon: Icon(
                      Icons.login,
                    ),
                  ),
                  BottomNavigationBarItem(
                    label: "Sign Up",
                    icon: Icon(
                      Icons.app_registration,
                    ),
                  ),
                ],
                currentIndex: _selectedIndex,
                onTap: _onItemTapped,
              ),
              body: toggleSignInSignUp(_selectedIndex),
            ),
          );
  }

  toggleSignInSignUp(int index) {
    if (index == 0) {
      //------------------------------ LOGIN---------------------
      return SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: LimitedBox(
                maxHeight: MediaQuery.of(context).size.height * 0.75,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 25,
                      child: Container(
                        child: Column(
                          children: [
                            Text(
                              "Welcome to \n ReHealth",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "A digital app that allows \n to create exercise routines for your patients",
                              style: TextStyle(
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 55,
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              Form(
                                key: _formKey,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    TextFormField(
                                      cursorColor: Colors.white,
                                      validator: (val) =>
                                          val.isEmpty ? "Enter an email" : null,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.all(
                                            8.0), //here your padding
                                        fillColor: Colors.grey[800],
                                        filled: true,
                                        hintText: 'Email',
                                        icon: Icon(
                                          Icons.email,
                                          color: Colors.white,
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: BorderSide(
                                              color: Colors.grey[700]),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: BorderSide(
                                              color: Colors.grey[800]),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: BorderSide(
                                              color: Colors.grey[800]),
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
                                      cursorColor: Colors.white,
                                      validator: (val) => val.isEmpty
                                          ? "Enter a password"
                                          : null,
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.all(
                                            8.0), //here your padding
                                        fillColor: Colors.grey[800],
                                        filled: true,
                                        hintText: 'password',
                                        icon: Icon(
                                          Icons.lock,
                                          color: Colors.white,
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: BorderSide(
                                              color: Colors.grey[700]),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: BorderSide(
                                              color: Colors.grey[800]),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: BorderSide(
                                              color: Colors.grey[800]),
                                        ),
                                      ),
                                      onChanged: (val) {
                                        password = val;
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 20,
                      child: Container(
                        child: Column(
                          children: [
                            Expanded(
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    child: Text("Sign In"),
                                    onPressed: () async {
                                      if (_formKey.currentState.validate()) {
                                        setState(() => loading = true);
                                        dynamic result = await _auth
                                            .signInWithEmailAndPassword(
                                                email, password);
                                        if (result == null) {
                                          setState(() {
                                            error =
                                                "Email or password incorrect";
                                            loading = false;
                                          });
                                        } else {
                                          navigateToUserHomePage(result);
                                        }
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                error,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 14,
                                ),
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
          ),
        ),
      );
    } else {
      //------------------------------ REGISTER---------------------
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    child: DropdownButton<Item>(
                      hint: Text("Select user"),
                      value: dropdownValue,
                      icon: const Icon(
                        Icons.arrow_downward,
                        color: Colors.white,
                      ),
                      iconSize: 24,
                      elevation: 16,
                      style: const TextStyle(fontSize: 16),
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
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    child: Scrollbar(
                      isAlwaysShown: true,
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                userContainer(), // ALL THE STUFF FOR EVERY USER
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    child: Column(
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                child: Text("Register"),
                                onPressed: () async {
                                  if (dropdownValue == null) return;
                                  if (_formKey.currentState.validate()) {
                                    setState(() => loading = true);
                                    User result;
                                    if (dropdownValue.type == "Worker") {
                                      result = await _auth
                                          .registerWithEmailAndPasswordWorker(
                                              email, password, username);
                                    } else if (dropdownValue.type == "Client") {
                                      result = await _auth
                                          .registerWithEmailAndPasswordClient(
                                              email,
                                              password,
                                              username,
                                              referral);
                                    } else if (dropdownValue.type ==
                                        "Individual") {
                                      result = await _auth
                                          .registerWithEmailAndPasswordIndividual(
                                              email, password, username);
                                    }
                                    if (result == null) {
                                      setState(() {
                                        error =
                                            "Invalid email or username already taken";
                                        loading = false;
                                      });
                                    } else {
                                      if (dropdownValue.type == "Worker") {
                                        DocumentSnapshot doc =
                                            await DatabaseService(
                                                    userName:
                                                        result.displayName,
                                                    userType:
                                                        dropdownValue.type)
                                                .getDocumentSnapshot();
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (contextCallback) =>
                                                HomeWorkerPage(
                                              user: result,
                                              document: doc,
                                            ),
                                          ),
                                        );
                                      } else if (dropdownValue.type ==
                                          "Client") {
                                        DocumentSnapshot doc =
                                            await DatabaseService(
                                                    userName:
                                                        result.displayName,
                                                    userType:
                                                        dropdownValue.type)
                                                .getDocumentSnapshot();
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (contextCallback) =>
                                                HomeClientPage(
                                              user: result,
                                              document: doc,
                                            ),
                                          ),
                                        );
                                      } else if (dropdownValue.type ==
                                          "Individual") {
                                        DocumentSnapshot doc =
                                            await DatabaseService(
                                                    userName:
                                                        result.displayName,
                                                    userType:
                                                        dropdownValue.type)
                                                .getDocumentSnapshot();
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (contextCallback) =>
                                                HomeIndividualPage(
                                              user: result,
                                              document: doc,
                                            ),
                                          ),
                                        );
                                      }
                                    }
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            error,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
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

  userContainer() {
    if (dropdownValue == null) {
      return Text("Please, select what type of user you are");
    }
    //----------------WORKER------------------
    else if (dropdownValue.type == "Worker") {
      return Column(
        children: [
          TextFormField(
            cursorColor: Colors.white,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(8.0), //here your padding
              fillColor: Colors.grey[800],
              filled: true,
              hintText: 'Enter your Username*',
              icon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.grey[700]),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.grey[800]),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.grey[800]),
              ),
            ),
            validator: (val) => val.isEmpty ? "Enter a username" : null,
            onChanged: (val) {
              setState(() {
                username = val;
              });
            },
          ),
          SizedBox(
            height: 50.0,
          ),
          TextFormField(
            cursorColor: Colors.white,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(8.0), //here your padding
              fillColor: Colors.grey[800],
              filled: true,
              hintText: 'Enter your Email*',
              icon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.grey[700]),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.grey[800]),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.grey[800]),
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
            height: 50.0,
          ),
          TextFormField(
            cursorColor: Colors.white,
            obscureText: true,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(8.0), //here your padding
              fillColor: Colors.grey[800],
              filled: true,
              hintText: 'Enter your password*',
              icon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.grey[700]),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.grey[800]),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.grey[800]),
              ),
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
            cursorColor: Colors.white,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(8.0), //here your padding
              fillColor: Colors.grey[800],
              filled: true,
              hintText: 'Enter your Username*',
              icon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.grey[700]),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.grey[800]),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.grey[800]),
              ),
            ),
            validator: (val) => val.isEmpty ? "Enter a username" : null,
            onChanged: (val) {
              setState(() {
                username = val;
              });
            },
          ),
          SizedBox(
            height: 50.0,
          ),
          TextFormField(
            cursorColor: Colors.white,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(8.0), //here your padding
              fillColor: Colors.grey[800],
              filled: true,
              hintText: 'Enter your Email*',
              icon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.grey[700]),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.grey[800]),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.grey[800]),
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
            height: 50.0,
          ),
          TextFormField(
            cursorColor: Colors.white,
            obscureText: true,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(8.0), //here your padding
              fillColor: Colors.grey[800],
              filled: true,
              hintText: 'Enter your password*',
              icon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.grey[700]),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.grey[800]),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.grey[800]),
              ),
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
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextFormField(
            cursorColor: Colors.white,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(8.0), //here your padding
              fillColor: Colors.grey[800],
              filled: true,
              hintText: 'Enter your Username*',
              icon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.grey[700]),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.grey[800]),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.grey[800]),
              ),
            ),
            validator: (val) => val.isEmpty ? "Enter a username" : null,
            onChanged: (val) {
              setState(() {
                username = val;
              });
            },
          ),
          SizedBox(
            height: 50.0,
          ),
          TextFormField(
            cursorColor: Colors.white,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(8.0), //here your padding
              fillColor: Colors.grey[800],
              filled: true,
              hintText: 'Enter your Email*',
              icon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.grey[700]),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.grey[800]),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.grey[800]),
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
            height: 50.0,
          ),
          TextFormField(
            cursorColor: Colors.white,
            obscureText: true,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(8.0), //here your padding
              fillColor: Colors.grey[800],
              filled: true,
              hintText: 'Enter your password*',
              icon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.grey[700]),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.grey[800]),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.grey[800]),
              ),
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
            height: 50.0,
          ),
          TextFormField(
            cursorColor: Colors.white,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(8.0), //here your padding
              fillColor: Colors.grey[800],
              filled: true,
              hintText: 'Enter worker username*',
              helperText:
                  "You need to provide your worker's name in order to link them",
              helperMaxLines: 2,
              icon: Icon(
                Icons.animation,
                color: Colors.white,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.grey[700]),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.grey[800]),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.grey[800]),
              ),
            ),
            validator: (val) {
              if (val.isEmpty)
                return "Enter a referral code";
              else
                return null;
            },
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

  navigateToUserHomePage(User user) async {
    DocumentSnapshot dc = await FirebaseFirestore.instance
        .collection("Worker")
        .doc(user.displayName)
        .get();
    if (dc.exists) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (contextCallback) => HomeWorkerPage(
            user: user,
            document: dc,
          ),
        ),
      );
    }

    dc = await FirebaseFirestore.instance
        .collection("Client")
        .doc(user.displayName)
        .get();
    if (dc.exists) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (contextCallback) => HomeClientPage(
            user: user,
            document: dc,
          ),
        ),
      );
    }

    dc = await FirebaseFirestore.instance
        .collection("Individual")
        .doc(user.displayName)
        .get();
    if (dc.exists) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (contextCallback) => HomeIndividualPage(
            user: user,
            document: dc,
          ),
        ),
      );
    }
  }

  Future<DocumentSnapshot> getUserDocumentSnapshot(User user) async {
    DocumentSnapshot dc = await FirebaseFirestore.instance
        .collection("Worker")
        .doc(user.displayName)
        .get();
    if (dc.exists) return dc;

    dc = await FirebaseFirestore.instance
        .collection("Client")
        .doc(user.displayName)
        .get();
    if (dc.exists) return dc;

    dc = await FirebaseFirestore.instance
        .collection("Individual")
        .doc(user.displayName)
        .get();
    if (dc.exists) return dc;

    return null;
  }
}

class Item {
  const Item(this.type);
  final String type;
}
