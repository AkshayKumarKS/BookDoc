import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/authentication/login.dart';
import 'package:project/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyAJ_ltekoautAP-i0zpBL8J5o7qaRzYQ54",
          appId: "1:802992401132:android:c5f1e832bd1c06990653c9",
          messagingSenderId: "802992401132",
          projectId: "progect-80cea"));
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Splash(),
  ));
}

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    getuserdata().whenComplete(() {
      if (finalEmail == false) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ak(),
            ));
      } else {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => home(),
            ));
      }
    });
    super.initState();
  }

  bool finalEmail = false;

  Future getuserdata() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainedEmail = sharedPreferences.getBool('islogged');
    setState(() {
      finalEmail = obtainedEmail!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return home();
  }
}

class ak extends StatefulWidget {
  const ak({super.key});

  @override
  State<ak> createState() => _akState();
}

bool isfinish = false;

class _akState extends State<ak> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  "lib/images/3.jpg",
                ),
                fit: BoxFit.fill)),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 400,
              ),
              Padding(
                padding: const EdgeInsets.all(30),
                child: SwipeableButtonView(
                  onFinish: () async {
                    await Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => login(),
                            fullscreenDialog: false));
                    setState(() {
                      isfinish = false;
                    });
                  },
                  isFinished: isfinish,
                  onWaitingProcess: () {
                    Future.delayed(Duration(seconds: 2), () {
                      setState(() {
                        isfinish = true;
                      });
                    });
                  },
                  activeColor: Colors.white,
                  buttonWidget: Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Colors.deepPurple,
                  ),
                  buttonText: "GET STARTED",
                  buttontextstyle: TextStyle(
                      color: Colors.deepPurple, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
