import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class forgotpassword extends StatelessWidget {
  const forgotpassword({super.key});

  @override
  Widget build(BuildContext context) {

    TextEditingController forgt = TextEditingController();

   void Reset (context)async{
     final email = forgt.text.trim();
     if(email.contains('@')){
       await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
       ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text('Reset your password sent to your ${email}'))
       );
     }
     else{
       ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(content: Text('Check your email  ${email}'))
       );
     }
   }
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 250,
          ),
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: TextField(
             controller: forgt,
             decoration: InputDecoration(
               hintText: 'Enter your email',
               border: OutlineInputBorder(),
             ),
           ),
         ),
          MaterialButton(onPressed: () {
            Reset(context);
          },child: Text("Sent Mail",style: TextStyle(fontWeight: FontWeight.w500),),)
        ],
      ),
    );
  }
}
