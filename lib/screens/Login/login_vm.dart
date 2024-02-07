import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/screens/Login/login_connector.dart';

class LoginViewModel extends ChangeNotifier{
  late LoginConnector loginConnector;

   Future<void> login(String emailAddress, String password) async {
     loginConnector.showLoading();
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      if(credential.user!.emailVerified){
        loginConnector.hideLoading();
        loginConnector.goToHome();
      }
      else {
       loginConnector.showMessage("please verify your email");
      }

    } on FirebaseAuthException catch (e) {
      if(e.code=="INVALID_LOGIN_CREDENTIALS"){}
      loginConnector.showMessage("wrong Email or password");
    }
  }
}