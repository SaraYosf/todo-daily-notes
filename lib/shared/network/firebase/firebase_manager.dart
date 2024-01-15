import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/models/task_model.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../models/user_model.dart';

class FirebaseManager {
  static CollectionReference<TaskModel> getTaskCollection() {
    return FirebaseFirestore.instance
        .collection("Tasks")
        .withConverter<TaskModel>(
      fromFirestore: (snapshot, _) {
        return TaskModel.fromJason(snapshot.data()!);
      },
      toFirestore: (task, _) {
        return task.toJson();
      },
    );
  }

  static CollectionReference<UserModel> getUserCollection() {
    return FirebaseFirestore.instance
        .collection("user")
        .withConverter<UserModel>(
      fromFirestore: (snapshot, _) {
        return UserModel.fromJason(snapshot.data()!);
      },
      toFirestore: (user, _) {
        return user.toJason();
      },
    );
  }

  static Future<void> addUser(UserModel user){
    var collection=getUserCollection();
    var docRef=collection.doc(user.id);
   return docRef.set(user);
  }

  static Future<void> addTask(TaskModel task) {
    var collection = getTaskCollection();
    var docRef = collection.doc();
    task.id = docRef.id;
    return docRef.set(task);
  }

  static Stream<QuerySnapshot<TaskModel>> getTask(DateTime date) {
    return getTaskCollection()
        .where("date",
            isEqualTo: DateUtils.dateOnly(date).millisecondsSinceEpoch)
        .snapshots();
  }

  static Future<void> deleteTask(String taskid) {
    return getTaskCollection().doc(taskid).delete();
  }

  static Future<void> updateIsDone(String id, bool isDone) {
    return getTaskCollection().doc(id).update({"isDone": isDone});
  }

  static Future<void> updateTask(TaskModel task) {
    return getTaskCollection().doc(task.id).update({
      "title": task.title,
      "description": task.description,
      "date": task.date
    });
  }

  static Future<void> createUser(String email,
      String password,
      String name,
      int age,

      Function onSuccess, Function onError) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      credential.user!.sendEmailVerification();
      UserModel userModel=UserModel(id: credential.user!.uid, name: name, age: age, email: email);
      addUser(userModel);
      onSuccess();
      credential.user!.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        onError(e.message);
      } else if (e.code == 'email-already-in-use') {
        onError(e.message);
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<void> login(String emailAddress, String password,
      Function onSuccess, Function onError) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      if(credential.user!.emailVerified){
        onSuccess();
      }
     else {
        onError("please verify your email");
      }

    } on FirebaseAuthException catch (e) {
     if(e.code=="INVALID_LOGIN_CREDENTIALS"){}
      onError("wrong Email or password");
    }
  }

  static Future<UserModel?> readUser(String userId)async{
   DocumentSnapshot<UserModel> userDoc=await getUserCollection().doc(userId).get();
return userDoc.data();
  }

static Future resetPassword(String email) async{
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      Container(
        color: Colors.red,
        child: Text("check your mail to reset password"),

  );
    }
    on FirebaseAuthException catch (e) {
print (e.message);
}}

 static Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
