import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:project/home.dart';

class BookingList extends StatefulWidget {
  const BookingList({super.key});

  @override
  State<BookingList> createState() => _BookingListState();
}

String? qrdata;

class _BookingListState extends State<BookingList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Bookings"),
        leading: IconButton(
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => home(),
                )),
            icon: Icon(Icons.navigate_before)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('book')
                    .where('userId',
                        isEqualTo: FirebaseAuth.instance.currentUser!.email)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    print(snapshot.error);
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  return SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final bookings = snapshot.data!.docs[index];
                        return ListTile(
                          title: Text(bookings['department']),
                          subtitle: Row(
                            children: [
                              Text(bookings['time']),
                              Text(bookings['booked_date'])
                            ],
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              String data = bookings['department'] +
                                  "_" +
                                  bookings['doctor'] +
                                  "_" +
                                  bookings['name'] +
                                  "_" +
                                  bookings['age'] +
                                  "_" +
                                  bookings['gender'] +
                                  "_" +
                                  bookings['time'] +
                                  "_" +
                                  bookings['booked_date'] +
                                  "_" +
                                  bookings['tokenNo'].toString()+"_"+bookings['phone'];
                              setState(() {
                                qrdata = data;
                              });
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: SizedBox(
                                      height: 250,
                                      child: Column(
                                        children: [
                                          if (qrdata != null)
                                            PrettyQrView.data(data: qrdata!)
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            icon: Icon(Icons.qr_code),
                          ),
                        );
                      },
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
