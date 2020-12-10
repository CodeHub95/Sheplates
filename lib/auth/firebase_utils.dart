import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_sheplates/auth/Auth.dart';

abstract class FirebaseMethods {
  void onCodeSent(String verificationId, [int forceResendingToken]);

  void onVerificationCompleted(AuthCredential phoneAuthCredential);

  void onVerificationFailed(AuthException authException);

  void onCodeAutoRetrievalTimeout(String verificationId);
}

class FirebasePresenter {
  FirebaseMethods methods;



  FirebasePresenter(this.methods);



  doPhoneAuth(String phoneNumber, {int forceResendingToken}) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        forceResendingToken: forceResendingToken,
        timeout: Duration(seconds: 60),
        verificationCompleted: methods.onVerificationCompleted,
        verificationFailed: methods.onVerificationFailed,
        codeSent: methods.onCodeSent,
        codeAutoRetrievalTimeout: methods.onCodeAutoRetrievalTimeout);
  }
}
