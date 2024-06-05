import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/bookigs/department_booking.dart';
import 'package:url_launcher/url_launcher.dart';

class Orthopedist extends StatelessWidget {
  const Orthopedist({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('data')
                  .where('specialvalue', isEqualTo: 'Orthopedist')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text("ERROR ::: ${snapshot.error}");
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final document = snapshot.data!.docs[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.6),
                                  offset: Offset(0.0, 10.0),
                                  blurRadius: 10.0,
                                  spreadRadius: -6.0,
                                ),
                              ],
                              image: DecorationImage(
                                  image: AssetImage("lib/images/h.jpeg"),
                                  fit: BoxFit.fill,
                                  opacity: 100)),
                          height: 300,
                          width: 400,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            document['image'].toString())),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "${document['name']}\n${document['specialvalue']}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "About\n${document['about']}",
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                              ),
                              Text(
                                "Consultation Time - ${document['start_time']} - ${document['end_time']}",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "General Consultation : ₹ ${document['fee']}",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        physicianbc(
                                                      department: 'Orthopedist',
                                                      doctor: document['name'],
                                                      time:
                                                          '${document['start_time']} - ${document['end_time']}',
                                                      token: document['tokens'],
                                                    ),
                                                  ));
                                            },
                                            child: Text("Book Consultation")),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ElevatedButton(
                                            onPressed: () async {
                                              String? encodeQueryParameters(
                                                  Map<String, String> params) {
                                                return params.entries
                                                    .map((MapEntry<String,
                                                                String>
                                                            e) =>
                                                        '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                                                    .join('&');
                                              }

                                              final Uri Launchemail = Uri(
                                                  scheme: 'mailto',
                                                  path:
                                                      document['doctor_email'],
                                                  query:
                                                      encodeQueryParameters(<String,
                                                          String>{
                                                    'subject':
                                                        'Requesting Advice'
                                                  }));
                                              if (await canLaunchUrl(
                                                  Launchemail)) {
                                                launchUrl(Launchemail);
                                              } else {
                                                throw Exception(
                                                    'could not launch $Launchemail');
                                              }
                                            },
                                            child: Text("Request Advice")),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
