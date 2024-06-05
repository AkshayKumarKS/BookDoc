import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project/authentication/phone_authentication.dart';
import 'package:project/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OTP extends StatefulWidget {
  const OTP({super.key});

  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  @override

  TextEditingController otp1 = TextEditingController();
  TextEditingController otp2 = TextEditingController();
  TextEditingController otp3 = TextEditingController();
  TextEditingController otp4 = TextEditingController();
  TextEditingController otp5 = TextEditingController();
  TextEditingController otp6 = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 400,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                "Enter the verification code we just sent to your number"),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: SizedBox(
                    height: 68,
                    width: 50,
                    child: TextFormField(
                      onChanged: (value) {
                        if (value.length == 1 ){FocusScope.of(context).nextFocus();
                        }
                      },
                      controller: otp1,
                      style: Theme.of(context).textTheme.headlineMedium,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: SizedBox(
                    height: 68,
                    width: 50,
                    child: TextFormField(
                      onChanged: (value) {
                        if (value.length == 1 ){FocusScope.of(context).nextFocus();
                        }
                      },
                      controller: otp2,
                      style: Theme.of(context).textTheme.headlineMedium,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      inputFormatters: [LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: SizedBox(
                    height: 68,
                    width: 50,
                    child: TextFormField(
                      onChanged: (value) {
                        if (value.length == 1 ){FocusScope.of(context).nextFocus();
                        }
                      },
                      controller: otp3,
                      style: Theme.of(context).textTheme.headlineMedium,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: SizedBox(
                    height: 68,
                    width: 50,
                    child: TextFormField(
                      onChanged: (value) {
                        if (value.length == 1 ){FocusScope.of(context).nextFocus();
                        }
                      },
                      controller: otp4,
                      style: Theme.of(context).textTheme.headlineMedium,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: SizedBox(
                    height: 68,
                    width: 50,
                    child: TextFormField(
                      onChanged: (value) {
                        if (value.length == 1 ){FocusScope.of(context).nextFocus();
                        }
                      },
                      controller: otp5,
                      style: Theme.of(context).textTheme.headlineMedium,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: SizedBox(
                    height: 68,
                    width: 50,
                    child: TextFormField(
                      onChanged: (value) {
                        if (value.length == 1 ){FocusScope.of(context).nextFocus();
                        }
                      },
                      controller: otp6,
                      style: Theme.of(context).textTheme.headlineMedium,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      inputFormatters: [LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Row(
              children: [
                Text("Dont Get OTP ? "),
                TextButton(onPressed: () {}, child: Text("Resent OTP"))
              ],
            ),
          ),
          ElevatedButton(
              onPressed: () async {
                try {
                  PhoneAuthCredential credential =
                  PhoneAuthProvider.credential(
                      verificationId: PHONE.verify,
                      smsCode: otp1.text +
                          otp2.text +
                          otp3.text +
                          otp4.text +
                          otp5.text +
                          otp6.text);
                  await FirebaseAuth.instance
                      .signInWithCredential(credential);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => home(),
                      ));
                  SharedPreferences preferences = await SharedPreferences.getInstance();
                  preferences.setBool('islogged', true);
                } catch (e) {
                  print(e);
                }
              },
              child: Text("DONE"))
        ],
      ),
    );
  }
}
