import 'package:chat_appication_vs/services/auth/firebase_auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/my_button.dart';
import '../components/my_text_field.dart';
class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const RegisterPage({super.key,required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final userNameController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // sign up method
  void signUp() async{
    String userEmail=emailController.text;
    String userPassword=passwordController.text;
    String userName=userNameController.text;
    final _auth=Provider.of<FireBaseAuthService>(context,listen: false);
    User? user= await _auth.signupWithEmailAndPassword(userEmail, userPassword,userName);
    if(passwordController.text != confirmPasswordController.text){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("password does not match")));

    }else if(user!=null){
      try{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("user created Successfully")));

        print("user created Successfully");
        Navigator.pushNamed(context, "/Home");
      }catch(e){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));

      }

    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("user already exist please login with this account")));
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
                    "Create New Account ",
                    style: TextStyle(fontSize: 30),
                  ),
                  //email textfield
                  const SizedBox(
                    height: 40,
                  ),
                  MyTextField(
                      controller: userNameController,
                      hintText: "UserName",
                      obscureText: false),
                  const SizedBox(
                    height: 10,
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
                  //password textfield
                  MyTextField(
                      controller: confirmPasswordController,
                      hintText: "Confirm Password",
                      obscureText: true),
                  const SizedBox(
                    height: 10,
                  ),
                  //login button
                  MyButton(onTap: signUp, text: "Sign up"),
                  const SizedBox(
                    height: 10,
                  ),
                  //register now
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already a User? "),
                      const SizedBox(
                        width: 4,
                      ),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(
                          "Login Now  ",
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
