import 'package:firebase_auth/firebase_auth.dart';
import 'package:training_app/Services/Database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // auth change user stream
  Stream<User> get user {
    return _auth.authStateChanges();
  }
  // sign in with e-mail and password

  // register with e-mail and password

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register with email and password
  Future registerWithEmailAndPassword(
      String email, String password, String username, String userType) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;

      //create a new document for the user
      await DatabaseService(userName: username, userType: userType)
          .updateUserData();

      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Login with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
