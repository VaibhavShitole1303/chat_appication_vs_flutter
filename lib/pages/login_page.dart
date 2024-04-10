import 'package:chat_appication_vs/components/my_button.dart';
import 'package:chat_appication_vs/components/my_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/auth/firebase_auth_services.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({super.key,required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text controller
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //signIn
  Future<void> signIn() async {
    String userEmail=emailController.text;
    String userPassword=passwordController.text;
    final _auth=Provider.of<FireBaseAuthService>(context,listen: false);
    User? user= await _auth.signInWithEmailAndPassword(userEmail, userPassword);
    if(user!=null){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Login Successfully")));


      print("Login Successfully");
      Navigator.pushNamed(context, "/Home");
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("please enter correct data")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //logo
                  const SizedBox(
                    height: 40,
                  ),
          
                  const Icon(
                    Icons.message,
                    size: 100,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
          
                  const Text(
                    "Welcome Back",
                    style: TextStyle(fontSize: 30),
                  ),
                  //email textfield
                  const SizedBox(
                    height: 40,
                  ),
          
                  MyTextField(
                      controller: emailController,
                      hintText: "Email",
                      obscureText: false),
                  const SizedBox(
                    height: 10,
                  ),
                  //password textfield
                  MyTextField(
                      controller: passwordController,
                      hintText: "Password",
                      obscureText: true),
                  const SizedBox(
                    height: 10,
                  ),
                  //login button
                  MyButton(onTap: signIn, text: "Sign InSign In"),
                  const SizedBox(
                    height: 10,
                  ),
                  //register now
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Not a User? "),
                      const SizedBox(
                        width: 4,
                      ),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(
                          "Register Now  ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
