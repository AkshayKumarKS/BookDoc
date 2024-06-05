// import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart'as firebase_storage;

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {

  String? image;

  TextEditingController name = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email1 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        body: Column(
          children: [
            SizedBox(height: 50),
            Center(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('Profile')
                      .where('email',
                      isEqualTo: FirebaseAuth.instance.currentUser!.email)
                      .snapshots(),
                  builder: (context, snapshot) {
                    final data = snapshot.data!.docs[0];
                    return Column(
                      children: [
                        Container(
                         decoration: BoxDecoration(
                           image: DecorationImage(image: AssetImage("lib/images/in face mask.jpeg"),
                           fit: BoxFit.fill)
                         ),
                          height: 300,
                          width: 400,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text("NAME : "),
                              Text(data['name']),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text("EMAIL : "),
                              Text(data['email']),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text("AGE : "),
                              Text(data['age']),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text("PHONE : "),
                              Text(data['phone']),
                            ],
                          ),
                        ),


                      ],
                    );
                  }
              ),
            ),
          ],
        ),
      ),
    );
  }
}



