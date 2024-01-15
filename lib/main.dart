import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/firebase_options.dart';
import 'package:todo/layouts/home_layouts.dart';
import 'package:todo/provider/my_provider.dart';
import 'package:todo/screens/login_and_sign_up/SignUpScreen.dart';
import 'package:todo/screens/login_and_sign_up/loginAndSignScreen.dart';
import 'package:todo/shared/style/theming.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  FirebaseFirestore.instance.disableNetwork();
  runApp( ChangeNotifierProvider(
    create: (context) => MyProvider(),
      child: const MyApp()));
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var provider =Provider.of<MyProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute:provider.firebaseUser!=null?HomeLayouts.routeName:LoginAndSign_up.routeName,
      routes: {
        HomeLayouts.routeName:(context) => const HomeLayouts(),
        LoginAndSign_up.routeName:(context)=>const LoginAndSign_up(),
        SignupScreen.routeName:(context)=>const SignupScreen()
      },
      themeMode: ThemeMode.light,
    theme: MyThemeData.lightTheme,
   // darkTheme:  MyThemeData.dartTheme,
    );
  }
}