import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth, FirebaseAuthException;
import 'package:flutter/material.dart';
import 'package:socialtap/components/button.dart';
import 'package:socialtap/components/text_filed.dart';



class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  // ignore: non_constant_identifier_names
  void SignIn() async {
       showDialog(
         context: context,
         builder:(context) => const Center(
        child: CircularProgressIndicator(),
       ) 
       );
      
    
    try {
  await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: emailTextController.text, 
    password: passwordTextController.text);

   if (context.mounted) Navigator.pop(context);


    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      displayMessage(e.code);

  // 
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
            
            
            
              const Icon(Icons.lock,
              size: 100,),
            
              const SizedBox(
                height: 50,
             ),
            
              //welcome back message
              const Text(
                "Welcome Back , you've been missed for a long"),
            
                 const SizedBox(
                  height: 50,
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
             
             MyButton(onTap: SignIn, text: 'Sign in'),

             const SizedBox(
              height: 25,
             ),

               Row(
                mainAxisAlignment: MainAxisAlignment.center,
              children: [
               Text("Not a member?",
               style: TextStyle(
                color: Colors.grey[700]
               )
               ,),

               const SizedBox(width: 4,),
               
                GestureDetector(
                  onTap: 
                    widget.onTap,
                  
                
               child: const Text("Register Now",
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