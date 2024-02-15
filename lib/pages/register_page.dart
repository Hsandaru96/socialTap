import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socialtap/components/text_filed.dart';

import '../components/button.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key,required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final confirmPaswordTextController = TextEditingController();

  void signUp() async {
    showDialog(
     context: context,
     builder: (context)=>const Center(
      child: CircularProgressIndicator(),
      )
     );


  if (passwordTextController.text != confirmPaswordTextController.text){
        Navigator.pop(context);
        displayMessage("Passwords don't match");
        return;
  }
  try{
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailTextController.text, password: passwordTextController.text);
   
   FirebaseFirestore.instance.collection("Users").doc(userCredential.user!.email!)
   .set({
    'username' : emailTextController.text,
    'bio' : 'Empty Bio'

  });


    if (context.mounted) Navigator.pop(context);
  } 
 on FirebaseAuthException catch (e) {
     Navigator.pop(context);
     displayMessage(e.code);
  }
}



void displayMessage(String message){
  showDialog(context: context,
   builder: (context) => AlertDialog(
    title: Text(message),
   )
   );
 }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[300],
      body:  SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
              //logo
            
            
            
              const Icon(Icons.account_circle_sharp,
              size: 100,),
            
              const SizedBox(
                height: 30,
             ),
            
              //welcome back message
              const Text(
                "Let's Create an Account for you"),
            
                 const SizedBox(
                  height: 20,
                ),
            
              //password Text filed
              MyTextFiled(
                controller:emailTextController,
                hintText: 'Email',
                 obsecureText: false),
              //sign in button
            
             const SizedBox(
                  height: 10,
                ),
            
            MyTextFiled(
              controller: passwordTextController,
               hintText: 'Password',
                obsecureText: 
               true),

               const SizedBox(
                  height: 10,
                ),
            
            MyTextFiled(
              controller: confirmPaswordTextController,
               hintText: 'Confirm Password',
                obsecureText: 
               true),
            
            const SizedBox(
              height: 10,
            ),
             
             MyButton(onTap: signUp, text: 'Sign up'),

             const SizedBox(
              height: 25,
             ),

               Row(
                mainAxisAlignment: MainAxisAlignment.center,
              children: [
               Text("Already have an account?",
               style: TextStyle(
                color: Colors.grey[700]
               )
               ,),

               const SizedBox(width: 4,),
               
                GestureDetector(
                  onTap: (
                    widget.onTap
                  ),
                
               child: const Text("Login ",
               style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue
               ),
               ),
               ),
              ],
             )


              //goto register page
              
              
              
              
              
              ],
            ),
          ),
        ),
      ),
    );
  }
}