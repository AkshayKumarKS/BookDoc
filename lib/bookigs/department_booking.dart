import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/bookigs/bookinglist.dart';

class physicianbc extends StatefulWidget {
  final String department;
  final String doctor;
  final String time;
  final int token;

  const physicianbc({super.key,
    required this.department,
    required this.doctor,
    required this.time,
    required this.token});

  @override
  State<physicianbc> createState() => _physicianbcState();
}

class _physicianbcState extends State<physicianbc> {
  String? qrdata;
  int currentToken = 0;

  String start = '';
  String end = '';
  TextEditingController name = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController phone = TextEditingController();

  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 1)), // Tomorrow
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<int> _generateToken() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('book')
        .where('department', isEqualTo: widget.department)
        .where('doctor', isEqualTo: widget.doctor)
        .where('booked_date', isEqualTo: _selectedDate.toString().split(" ")[0])
        .get();
    final tokens = snapshot.docs.map((doc) => doc['tokenNo'] as int).toList();
    tokens.sort();
    for (int i = 1; i <= widget.token; i++) {
      if (tokens.contains(i)) {
        continue;
      }else{
        return i;
      }
    }
    throw Exception('No available tokens');
  }

  Bookconsultation() async {
    try {
      final tokenNo = await _generateToken();
      await FirebaseFirestore.instance.collection('book').add({
        'department': widget.department,
        'doctor': widget.doctor,
        'name': name.text,
        'age': age.text,
        'gender': gender.text,
        'time': widget.time,
        'booked_date': _selectedDate.toString().split(" ")[0],
        'userId': FirebaseAuth.instance.currentUser!.email,
        'tokenNo': tokenNo,
        'phone':phone.text,
      });
      showDialog(context: context, builder: (context) =>
          AlertDialog(
            title: Text('Consultation Booking'),
            content: Text('Doctor: ${widget.doctor}\nDepartment: ${widget
                .department}\nTime: $start-$end\nDate: ${_selectedDate
                .toString().split(" ")[0]}\nToken Number: $tokenNo'),
            actions: [
              TextButton(onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => BookingList(),));
              }, child: Text('OK'))
            ],
          ),);
    } catch (e) {
      print(e);
      showDialog(context: context, builder: (context) =>
          AlertDialog(
            title: Text('error'),
            content: Text('could not book consultation : $e'),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context), child: Text("OK"))
            ],
          ),);
    }
  }

  TextEditingController date = TextEditingController();


  @override
  Widget build(BuildContext context) {
    date.text =  _selectedDate == null
        ? 'No date selected'
        : 'Selected Date: ${_selectedDate.toString().split(
        " ")[0]}';

    final size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("lib/images/booking page.jpeg"),fit: BoxFit.fill)
              ),
                child: Column(
                  children: [
                    TextField(
                      controller: name,
                      decoration: InputDecoration(labelText: "Name"),
                    ),
                    TextField(
                      keyboardType: TextInputType.phone,
                      controller: age,
                      decoration: InputDecoration(labelText: "Age"),
                    ),
                    TextField(
                      controller: gender,
                      decoration: InputDecoration(labelText: "Gender"),
                    ),
                    TextField(
                      controller: phone,
                      decoration: InputDecoration(labelText: "Phone number"),
                    ),
                    TextField(
                      onTap: () => _selectDate(context),
                      controller: date,
                      decoration: InputDecoration(labelText: "Date"),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    // date
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Text(
                    //     _selectedDate == null
                    //         ? 'No date selected'
                    //         : 'Selected Date: ${_selectedDate.toString().split(
                    //         " ")[0]}',
                    //     style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                    //   ),
                    // ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        SizedBox(
                          width: 50,
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: ElevatedButton(
                        //     onPressed: () => _selectDate(context),
                        //     child: Text('Select Date'),
                        //   ),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.only(left: 30),
                        //   child: ElevatedButton(onPressed: () {
                        //   }, child: Text("Token NO  : $token")),
                        // )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          onPressed: () {
                            if (name.text == '' || age.text == '' ||
                                gender.text == ''|| phone.text=='' || _selectedDate == null) {
                              showDialog(context: context, builder: (context)
                              {
                                return AlertDialog(
                                  title: Text("Alert ! "),
                                  content: Text('Slot Empty'),
                                  actions: [
                                    TextButton(onPressed: () {
                                      Navigator.pop(context);
                                    }, child: Text("OK")),
                                  ],
                                );
                              });
                            } else {
                              Bookconsultation();
                            }
                          },


                          child: Text("BOOK CONSULTATION")),
                    ),
                  ],
                ),
              ),
            )));
  }
}
