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
  Future registerWithEmailAndPasswordWorker(
      String email, String password, String username) async {
    try {
      //Avoid repeated Usernames
      bool repeated =
          await DatabaseService(userName: username, userType: "Worker")
              .checkIfUserNameIsTaken();
      if (repeated) return null;

      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;

      await FirebaseAuth.instance.currentUser
          .updateProfile(displayName: username);
      await FirebaseAuth.instance.currentUser.reload();

      //create a new document for the user
      await DatabaseService(userName: username, userType: "Worker")
          .updateUserDataWorker();

      return FirebaseAuth.instance.currentUser;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register with email and password for Client
  Future registerWithEmailAndPasswordClient(
      String email, String password, String username, String referral) async {
    try {
      //Avoid repeated Usernames
      bool repeated =
          await DatabaseService(userName: username, userType: "Client")
              .checkIfUserNameIsTaken();
      if (repeated) return null;

      //Check if the referral worker is correct
      bool validReferral =
          await DatabaseService(userName: username, userType: "Client")
              .checkIfReferralWorkerExist(referral);
      if (!validReferral) return null;

      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;

      await FirebaseAuth.instance.currentUser
          .updateProfile(displayName: username);
      await FirebaseAuth.instance.currentUser.reload();

      //create a new document for the user
      await DatabaseService(userName: username, userType: "Client")
          .updateUserDataClient(referral);

      return FirebaseAuth.instance.currentUser;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register with email and password
  Future registerWithEmailAndPasswordIndividual(
      String email, String password, String username) async {
    try {
      //Avoid repeated Usernames
      bool repeated =
          await DatabaseService(userName: username, userType: "Individual")
              .checkIfUserNameIsTaken();
      if (repeated) return null;

      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;

      await FirebaseAuth.instance.currentUser
          .updateProfile(displayName: username);
      await FirebaseAuth.instance.currentUser.reload();

      //create a new document for the user
      await DatabaseService(userName: username, userType: "Individual")
          .updateUserDataIndividual();

      return FirebaseAuth.instance.currentUser;
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
