import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/models/user_model.dart';
import 'package:todo/shared/network/firebase/firebase_manager.dart';

class MyProvider extends ChangeNotifier{

  UserModel? userModer;
  User? firebaseUser;

  userProvider(){
firebaseUser= FirebaseAuth.instance.currentUser;
if( firebaseUser!= null){
  initUser();
}
  }
  initUser()async{
    firebaseUser=FirebaseAuth.instance.currentUser;
  userModer =await FirebaseManager.readUser(firebaseUser!.uid);
  notifyListeners();
  }

}