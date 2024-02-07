import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:todo/layouts/home_layouts.dart';
import 'package:todo/screens/Login/login_connector.dart';
import '../../shared/network/firebase/firebase_manager.dart';
import '../login_and_sign_up/SignUpScreen.dart';
import 'login_vm.dart';

class LoginScreen extends StatefulWidget{
  static const String routeName = "login";

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>  implements LoginConnector{
  final _formkey = GlobalKey<FormState>();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();
 final GoogleSignIn googleSignIn=GoogleSignIn();
  LoginViewModel viewModel=LoginViewModel();
  @override
  void initState() {
    viewModel.loginConnector=this;
  }
  @override
  Widget build(BuildContext context) {
    return
      ChangeNotifierProvider(
        create: (context) => viewModel,
        builder:(context, child) =>  DefaultTabController(
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
              body:  TabBarView(children: [
                Form(
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
                              r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
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
                            if(_formkey.currentState!.validate()) {
                              viewModel.login(
                                  emailController.text, passwordController.text);
                              /* FirebaseManager.login(
                            emailController.text, passwordController.text, () {
                              provider.initUser();
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
                        });*/
                            }
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
                          onLoading();
                          FirebaseManager.signInWithGoogle().then((value) {
                            Navigator.pop(context);
                            Navigator.pushNamedAndRemoveUntil(
                                context, HomeLayouts.routeName, (route) => false);
                          });

                        },
                        child: Image.asset('assets/images/google-logo.png',width: 50,height: 50,),),

                    ],
                  ),
                ),
                 SignupScreen()
              ],)
          ),
        ),
      );
  }

  @override
  goToHome() {
    Navigator.pushNamedAndRemoveUntil(
        context, HomeLayouts.routeName, (route) => false);
  }

  @override
  hideLoading() {
    Navigator.pop(context);
  }

  @override
  showLoading() {
    showDialog(context: context, builder: (context) => AlertDialog(
      title: Center(
        child: CircularProgressIndicator(

        ),
      ),
    ),);
  }

  @override
  showMessage(String message) {
  showDialog(context: context,
      builder: (context) => AlertDialog(title: Text("Error"),content: Text(message),
      actions: [
        ElevatedButton(onPressed: (){}, child: Text("okay"))
      ],),);
  }

  onLoading() {
    showDialog(context: context, builder: (context) => AlertDialog(
      title: Center(
        child: CircularProgressIndicator(
        ),
      ),
    ),);

  }

}
