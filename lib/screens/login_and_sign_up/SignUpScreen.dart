import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/provider/my_provider.dart';
import 'package:todo/shared/network/firebase/firebase_manager.dart';

import '../../layouts/home_layouts.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});
static const String routeName="signUp";
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}
class _SignupScreenState extends State<SignupScreen> {
  final _formkey = GlobalKey<FormState>();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var nameController = TextEditingController();

  var ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    var provider= Provider.of<MyProvider>(context);
    return Padding(

        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 22),
      child: Form(
        key: _formkey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(hintText: "your name"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'please enter name';
                }
                return null;
              },
            ),
            TextFormField(
              controller: ageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: "your aga "),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'please enter email';
                }
                return null;
              },
            ),
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(hintText: "email "),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'please enter email';
                }
                final bool emailValid = RegExp(
                    r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(value);
                if (!emailValid) {
                  return "invalid email";
                }
                return null;
              },
            ),
            TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(hintText: "password "),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'please enter passord';
                }
                return null;
              },
            ),
            const SizedBox(height: 20,),
            ElevatedButton(
                onPressed: () {
                  if (_formkey.currentState!.validate()) {
                    FirebaseManager.createUser(
                        emailController.text,
                        passwordController.text,
                        nameController.text,
                        int.parse(ageController.text),
                            () {
                              provider.initUser();
                      Navigator.pushNamedAndRemoveUntil(
                          context, HomeLayouts.routeName, (route) => false);
                    }, (error) {
                      return showDialog(
                        barrierDismissible: false,
                        context: context, builder: (context) =>
                            AlertDialog(actions: [
                              ElevatedButton(onPressed: () {
                                Navigator.pop(context);
                              }, child: const Text("okay"))
                            ],
                              title: const Text("Error"),
                              content: Text(error.toString()),
                            ),
                      );
                    });
                  }
                }, child: const Text("Sign Up"))
          ],
        ),
      ),);
  }
}
