import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo/firebase_options.dart';
import 'package:todo/layouts/home_layouts.dart';
import 'package:todo/screens/login_and_sign_up/SignUpScreen.dart';
import 'package:todo/screens/login_and_sign_up/loginAndSignScreen.dart';
import 'package:todo/screens/tasks/edit_task.dart';
import 'package:todo/shared/style/theming.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  FirebaseFirestore.instance.disableNetwork();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: LoginAndSign_up.routeName,
      routes: {
        HomeLayouts.routeName:(context) => HomeLayouts(),
        LoginAndSign_up.routeName:(context)=>LoginAndSign_up(),
        SignupScreen.routeName:(context)=>SignupScreen()
      },
      themeMode: ThemeMode.light,
    theme: MyThemeData.lightTheme,
   // darkTheme:  MyThemeData.dartTheme,
    );
  }
}
