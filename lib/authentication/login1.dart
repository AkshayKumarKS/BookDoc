import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/authentication/forgot_password.dart';
import 'package:project/home.dart';
import 'package:project/authentication/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

class login1 extends StatefulWidget {
  const login1({super.key});

  @override
  State<login1> createState() => _login1State();
}

class _login1State extends State<login1> {

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  login()async{
   try{
     final user =  await FirebaseAuth.instance.signInWithEmailAndPassword(email: email.text, password: password.text);
     if(user != null){
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login successful")));
       Navigator.push(
           context,
           MaterialPageRoute(
             builder: (context) => home(),
           ));
     }
   }catch(e){
     print("ERROR: $e");
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Email or password invalid")));
   }
  }

  bool _isObscure = true;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Login"),
      // ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("lib/images/log.jpeg"), fit: BoxFit.fill)),
        child: Center(
          child: SizedBox(
            height: 600,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(40),
                    child: TextField(
                      controller: email,
                      decoration: InputDecoration(
                          labelText: "Email ",
                        suffixIcon: Icon(Icons.email,weight: 400,color: Colors.black87,)
                          ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(40),
                    child: TextField(
                      obscureText: _isObscure,
                      controller: password,
                      decoration: InputDecoration(
                        labelText: "Password",
                        suffixIcon: IconButton(onPressed: () {
                          setState(() {
                            _isObscure=!_isObscure;
                          });
                        },icon: Icon(_isObscure?Icons.visibility:Icons.visibility_off),)
                        ),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(alignment: Alignment.bottomRight,
                      child: TextButton(onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (BuildContext )=>forgotpassword()));
                      }, child: Text("Forgot Password?"),),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async{
                      SharedPreferences preferences = await SharedPreferences.getInstance();
                      preferences.setBool('islogged', true);
                      login();

                    },
                    child: Text("Login"),
                  ),
                  TextButton(onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => signup(),));
                  }, child: Text("Dont have an account ? Sign in"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
