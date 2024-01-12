import 'package:flutter/material.dart';
import 'package:todo/screens/login_and_sign_up/LoginScreen.dart';
import 'package:todo/screens/login_and_sign_up/SignUpScreen.dart';

class LoginAndSign_up extends StatelessWidget {
  const LoginAndSign_up({super.key});
static const String routeName="login";
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,

      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text("Login"),
          bottom: const TabBar(
            tabs: [Tab(text: "Login",),

              Tab(text: "Sign up",)
            ],
        ),
       ),
          body: const TabBarView(children: [
            LoginScreen(),
            SignupScreen()
          ],)
      ),
    );
  }
}
