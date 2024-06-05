import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project/authentication/login1.dart';
import 'package:project/authentication/phone_authentication.dart';
import 'package:project/authentication/signup.dart';
import 'package:project/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}



class _loginState extends State<login> {
  @override
  Widget build(BuildContext context) {

    Future googleSignin() async {
      try {
        final google = GoogleSignIn();
        final user = await google.signIn().catchError((onerror) {});
        final auth = await user!.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: auth.accessToken,
          idToken: auth.idToken,
        );

        FirebaseAuth.instance.signInWithCredential(credential);
        final SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setBool('islogged', true);
        Navigator.push(context, MaterialPageRoute(builder: (context) => home(),));
      } catch (e) {
        print(e);
      }
    }


    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("lib/images/12.jpg"), fit: BoxFit.fitHeight)),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 400,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => login1(),
                      ));
                },
                child: Row(
                  children: [
                    SizedBox(
                      width: 40,
                    ),
                    CircleAvatar(
                      backgroundImage: AssetImage('lib/images/email.jpeg'),
                    ),
                    Text("LOG IN WITH E MAIL"),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  googleSignin();
                },
                child: Row(
                  children: [
                    SizedBox(
                      width: 40,
                    ),
                    CircleAvatar(
                      backgroundImage: AssetImage('lib/images/google.jpeg'),
                    ),
                    Text("CONTINUE WITH GOOGLE"),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PHONE(),
                      ));
                },
                child: Row(
                  children: [
                    SizedBox(
                      width: 40,
                    ),
                    CircleAvatar(
                      backgroundImage: AssetImage('lib/images/phone.jpeg'),
                    ),
                    Text("LOG IN WITH PHONE NUMBER"),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => signup(),
                      ));
                },
                child: Text("Don't Have An Account?SIGN UP"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
