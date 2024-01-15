import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo/layouts/home_layouts.dart';

import '../../shared/network/firebase/firebase_manager.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "login";

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formkey = GlobalKey<FormState>();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();
 final GoogleSignIn googleSignIn=GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    double wid=0;
    double high=0;
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 22),
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(hintText: "email "),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'please enter email';
                  }
                  final bool emailValid = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value);
                  if (!emailValid) {
                    return "invalid email";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(hintText: "password "),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'please enter password';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),),),
                  onPressed: () {
                    FirebaseManager.login(
                        emailController.text, passwordController.text, () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, HomeLayouts.routeName, (route) => false);
                    }, (error) {
                      return showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) => AlertDialog(
                          actions: [
                            ElevatedButton(
                                onPressed: () {


                                  Navigator.pop(context);
                                },
                                child: const Text("okay"))
                          ],
                          title: const Text("Error"),
                          content: Text(error.toString()),
                        ),
                      );
                    });
                  },
                  child: const Text("Login")),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                   showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) => AlertDialog(
                      actions: [
                        ElevatedButton(
                            onPressed: () {


                              Navigator.pop(context);
                            },
                            child: const Text("okay"))
                      ],
                      title: const Text("alert"),
                      content: Text("check your mail to reset password"),
                    ),
                  );

                FirebaseManager.resetPassword(emailController.text.trim());

                },
                child: const Center(child: Text("forget password ?",style: TextStyle(color: Colors.blue),)),
              ),
              const SizedBox(height: 50,),
              InkWell(
                onTap: (){
                  FirebaseManager.signInWithGoogle().then((value) {
                    Navigator.pushNamedAndRemoveUntil(
                        context, HomeLayouts.routeName, (route) => false);
                  });

                },
                  child: Image.asset('assets/images/google-logo.png',width: 50,height: 50,),),

            ],
          ),
        ));
  }



}
