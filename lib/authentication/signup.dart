import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/home.dart';
import 'package:project/authentication/login1.dart';
import 'package:shared_preferences/shared_preferences.dart';

class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

final CollectionReference call =
    FirebaseFirestore.instance.collection("Profile");

class _signupState extends State<signup> {
  TextEditingController email1 = TextEditingController();
  TextEditingController password1 = TextEditingController();
  TextEditingController password2 = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController phone = TextEditingController();

  fnc() {
    final data = {
      "email": email1.text,
      "password": password1.text,
      "name": name.text,
      "age": age.text,
      "phone": phone.text,
    };
    call.add(data);
  }

  signup() async {
    try {
      final user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email1.text, password: password1.text);
      if (user != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Account Created Successfully")));
        fnc();
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => home(),
            ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Something went wrong")));
      print("error $e");
    }
  }

  String? _email;
  String? _emailErrorText;
  String? _passwordError;

  bool _validateEmail(String value) {
    // Regular expression for basic email validation
    String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regex = RegExp(emailPattern);
    return regex.hasMatch(value);
  }

  bool _isObscure1 = true;
  bool _isObscure2 = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          // appBar: AppBar(
          //   title: Text("SignUp"),
          // ),
          body: Container(
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade100.withOpacity(0.3),
                  offset: Offset(6.0, 10.0),
                  blurRadius: 5.0,
                  spreadRadius: -9.0)
            ],
            image: DecorationImage(
                image: AssetImage("lib/images/sp.jpeg"), fit: BoxFit.fill)),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [

                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(left: 30, top: 30, right: 30),
                  child: TextField(
                    controller: name,
                    decoration: InputDecoration(
                      labelText: "Name",
                      suffixIcon: Icon(Icons.perm_identity),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: TextField(
                    keyboardType: TextInputType.phone,
                    controller: age,
                    decoration: InputDecoration(
                      labelText: "Age",
                      suffixIcon: Icon(Icons.perm_identity),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: TextField(
                    keyboardType: TextInputType.phone,
                    controller: phone,
                    decoration: InputDecoration(
                      labelText: "Phone No",
                      suffixIcon: Icon(Icons.phone),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: TextFormField(
                    onChanged: (value) {
                      setState(() {
                        _email = value;
                        _emailErrorText = _validateEmail(value)
                            ? null
                            : 'Please enter a valid email address';
                      });
                    },
                    keyboardType: TextInputType.emailAddress,
                    controller: email1,
                    decoration: InputDecoration(
                      labelText: "Email",
                      errorText: _emailErrorText,
                      suffixIcon: Icon(Icons.email),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: TextField(
                    obscureText: _isObscure1,
                    controller: password1,
                    decoration: InputDecoration(
                      labelText: "Password",
                      suffixIcon: IconButton(
                        icon: Icon(_isObscure1?Icons.visibility:Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _isObscure1=!_isObscure1;
                          });
                        },
                      )
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: TextField(
                    obscureText: _isObscure2,
                    controller: password2,
                    onChanged: (value) {
                      setState(() {
                        _passwordError = password1.text == value
                            ? null
                            : 'Password does not match';
                      });
                    },
                    decoration: InputDecoration(
                      labelText: "Repeat Password",
                      errorText: _passwordError,
                      suffixIcon: IconButton(onPressed: () {
                        setState(() {
                          _isObscure2=!_isObscure2;
                        });
                      },
                        icon: Icon(_isObscure2?Icons.visibility:Icons.visibility_off),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: ElevatedButton(
                      onPressed: () async {
                        if (_validateEmail(_email!) &&
                            (password1.text == password2.text)) {
                          // Email is valid, do something with it
                          SharedPreferences preferences = await SharedPreferences.getInstance();
                          preferences.setBool('islogged', true);
                          signup();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Email is valid'),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Email or password is not valid'),
                            ),
                          );
                        }
                      },
                      child: Text("DONE")),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => login1(),
                          ));
                    },
                    child: Text("Already have an account ? Log in"))
              ],
            ),
          ),
        ),
      )),
    );
  }
}
