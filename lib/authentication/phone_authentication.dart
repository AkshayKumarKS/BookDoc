import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/authentication/OTP.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PHONE extends StatefulWidget {
  static String verify='';

  const PHONE({super.key});

  @override
  State<PHONE> createState() => _phoneState();
}

class _phoneState extends State<PHONE> {
  @override

  TextEditingController phone = TextEditingController();
  TextEditingController countrycode = TextEditingController();

  authFunction(BuildContext context) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: countrycode.text + phone.text,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await FirebaseAuth.instance.signInWithCredential(credential);

        // store the authentication status

        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setBool('islogged', true);
      },
      verificationFailed: (FirebaseAuthException error) {
        print(error);
      },
      codeSent: (String verificationId, int? forceResendingToken) async {
        PHONE.verify = verificationId;
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OTP(),
            ));
      },
      codeAutoRetrievalTimeout: (verificationId) {
        print("Timeout");
      },
    );
  }


  Widget build(BuildContext context) {
    countrycode.text = " + 91 " ;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 400,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  "Enter Phone Number",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 60,
                  child: TextField(
                    controller: countrycode,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      // labelText: "+91",
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.zero))),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 200,
                  child: TextField(
                    controller: phone,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        labelText: "Enter Phone Number",
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.zero))),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: () {
                  authFunction(context);

                  Navigator.push(context, MaterialPageRoute(builder: (context) => OTP(),));
                },
                child: Text("Get OTP")),
          )
        ],
      ),
    );
  }
}
