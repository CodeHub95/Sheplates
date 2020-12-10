import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_sheplates/auth/firebase_utils.dart';
import 'package:flutter_sheplates/modals/response/loginresponse.dart';


enum AuthState { LoggedIn, LoggedOut }

class Auth {
  static Auth _instance = new Auth.internal();
  AuthState authState;
  Profile profile;
  String token;

  FirebaseMethods methods;

  FirebaseAuth firebaseAuth;
  FirebaseUser firebaseUser;

  Auth.internal() {
    firebaseAuth = FirebaseAuth.instance;
  }

  factory Auth() => _instance;
}
