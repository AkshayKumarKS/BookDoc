import 'package:advance_pdf_viewer2/advance_pdf_viewer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:project/bookigs/bookinglist.dart';
import 'package:project/departments/Cardiologist.dart';
import 'package:project/departments/Dermatologist.dart';
import 'package:project/departments/Gastroenterologist.dart';
import 'package:project/departments/Gynacologist.dart';
import 'package:project/departments/Neurologist.dart';
import 'package:project/departments/Oncologist.dart';
import 'package:project/departments/Ophthalmologist.dart';
import 'package:project/departments/Orthopedist.dart';
import 'package:project/departments/Otolaryngologist.dart';
import 'package:project/departments/Paediatricion.dart';
import 'package:project/departments/Physician.dart';
import 'package:project/departments/Physiotherapist.dart';
import 'package:project/departments/Psychiatrist.dart';
import 'package:project/departments/Surgeon.dart';
import 'package:project/departments/Urologist.dart';
import 'package:project/authentication/login.dart';
import 'package:project/authentication/profile_page.dart';
import 'package:project/pdf/readpdf.dart';
import 'package:shared_preferences/shared_preferences.dart';

Navi(context, p1) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => p1));
}

class home extends StatefulWidget {
  home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  List pages = [
    Physician(),
    Surgeon(),
    Paediartricion(),
    Gynacologist(),
    Psychiatrist(),
    Cardiologist(),
    Neurologist(),
    Opthalmologist(),
    Dermatologist(),
    Physiotherapist(),
    Orthopedist(),
    Urologist(),
    Otolaryngologist(),
    Gastroenterologist(),
    Oncologist()
  ];

  List data = [
    "Physician",
    "Surgeon",
    "Paediatricion",
    "Gynacologist",
    "Psychiatrist",
    "Cardiologist",
    "Neurologist",
    "Ophthalmologist",
    "Dermatologist",
    "Physiotherapist",
    "Orthopedist",
    "Urologist",
    "Otolaryngologist",
    "Gastroenterologist",
    "Oncologist"
  ];

  List images = [
    "lib/images/physician.jpeg",
    "lib/images/Surgeon.jpg",
    "lib/images/Paediatricion.jpg",
    "lib/images/Gynacologist.jpg",
    "lib/images/Psychiatrist.jpg",
    "lib/images/Cardiologist.jpg",
    "lib/images/neuro.jpg",
    "lib/images/Ophthalmologist.jpg",
    "lib/images/Dermatologist.jpg",
    "lib/images/Physiotherapist.jpg",
    "lib/images/Orthopedist.jpg",
    "lib/images/Urologist.jpg",
    "lib/images/Otolaryngologist.jpg",
    "lib/images/Gastroenterologist.jpg",
    "lib/images/Oncologist.jpg"
  ];


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double postheight = (size.height - kToolbarHeight - 24) / 3.5;
    final double postwidth = size.width / 2;
    return Scaffold(
        appBar: AppBar(
          title: Text("Who Do You Want To Consult",style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),),
          automaticallyImplyLeading: false,
        ),
        endDrawer: Drawer(
          child: ListView(
            children: [
              Container(
                height: 250,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage('lib/images/logo.jpeg'),fit: BoxFit.fill)
                ),
              ),
              // UserAccountsDrawerHeader(
              //   accountName: Text("akshay"),
              //   accountEmail: Text("akshay@gmail.com"),
              //   currentAccountPicture: CircleAvatar(
              //     backgroundImage: AssetImage("lib/images/logo.jpeg"),
              //   ),
              // ),
              // ListTile(
              //   title: Text("My profile"),
              //   trailing: IconButton(
              //     onPressed: () {
              //       Navigator.push(context, MaterialPageRoute(builder: (context) => profile(),));
              //     },
              //     icon: Icon(Icons.account_circle_rounded),
              //   ),
              // ),
              ListTile(
                title: Text("My Bookings"),
                trailing: IconButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => BookingList(),));
                    }, icon: Icon(Icons.library_books_outlined)),
              ),
              ListTile(
                trailing: Icon(
                  Icons.lock,
                  color: Colors.black,
                ),
                title: Text(
                  'Privacy Policy',
                  style: TextStyle(color: Colors.black),
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (builder) {
                      return Settingmenupopup(
                          mdFilename: 'privacy policy.md');
                    },
                  );
                },),

              ListTile(
                trailing: Icon(
                  Icons.newspaper,
                  color: Colors.black,
                ),
                title: Text(
                  'Terms and Conditions',
                  style: TextStyle(color: Colors.black),
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (builder) {
                      return Settingmenupopup(
                          mdFilename: 'terms and condition.md');
                    },
                  );
                },),


              ListTile(
                title: Text("Log Out"),
                trailing: IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          height: 200,
                          width: 200,
                          child: AlertDialog(
                            title: Text("LogOut"),
                            content: Text("Are you sure you want logout"),
                            actions: [
                              ElevatedButton(
                                  onPressed: () async{
                                    FirebaseAuth.instance.signOut();
                                    SharedPreferences preference = await SharedPreferences.getInstance();
                                    preference.setBool('islogged',false);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => login(),
                                        ));
                                  },
                                  child: Text("Yes")),
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("No"))
                            ],
                          ),
                        );
                      },
                    );
                  },
                  icon: Icon(Icons.logout_outlined),
                ),
              ),
              EndDrawerButton(
                onPressed: () {},
              )
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 200,
                child: CarouselSlider(

                    items: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ReadPdf(pdfurl: 'lib/pdf/Health Tips for Kids.pdf',),));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("lib/images/kids.jpeg"),
                                    fit: BoxFit.fill)),
                            height: 50,
                            width: 250,

                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ReadPdf(pdfurl: 'lib/pdf/Pregnancy_Book.pdf',),));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                // border: Border.all(color: Colors.blue),
                                image: DecorationImage(
                                    image: AssetImage("lib/images/pregnancy.png"),
                                    fit: BoxFit.fill)),
                            height: 50,
                            width: 250,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ReadPdf(pdfurl: 'lib/pdf/senior_citizen.pdf',),));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                // border: Border.all(color: Colors.blue, width: 3),
                                image: DecorationImage(
                                    image: AssetImage("lib/images/senior citizen.png"),
                                    fit: BoxFit.fill)),
                            height: 50,
                            width: 250,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ReadPdf(pdfurl: 'lib/pdf/gastro.pdf',),));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                // border: Border.all(color: Colors.blue),
                                image: DecorationImage(
                                    image: AssetImage("lib/images/Gastro.png"),
                                    fit: BoxFit.fill)),
                            height: 50,
                            width: 250,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ReadPdf(pdfurl: 'lib/pdf/skincare.pdf',),));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              // border: Border.all(color: Colors.blue),
                                image: DecorationImage(
                                    image: AssetImage("lib/images/skin.png"),
                                    fit: BoxFit.fill)),
                            height: 50,
                            width: 250,
                          ),
                        ),
                      ),
                    ],
                    options: CarouselOptions(
                        viewportFraction: 0.8,
                        animateToClosest: true,
                        padEnds: true,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 2),
                        height: 200,

                        scrollDirection: Axis.horizontal,
                         aspectRatio: 200 / 9,
                        disableCenter: true
    )),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: GridView.builder(
                      itemCount: pages.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1,
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 2.0),
                      itemBuilder: (context, index) {
                        return refactor(
                          ontap: () => Navi(context, pages[index]),
                          name: data[index],
                          image: AssetImage(images[index]), postheight: postheight, postwidth: postwidth,
                        );
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

class refactor extends StatelessWidget {
  refactor(
      {super.key,
      required this.ontap,
      required this.name,
      required this.image,required this.postheight,required this.postwidth});

  void Function()? ontap;
  final String? name;
  final ImageProvider image;
  final postheight;
  final postwidth;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: postheight,
        width: postwidth,
        child: Column(
          children: [
            Image(
              image: image,
              fit: BoxFit.fill,
            ),
            Text(
              name!,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        // child: Center(
        //     child: Text(
        //   name!,
        //   style: TextStyle(fontWeight: FontWeight.bold),
        // )),
        // decoration: BoxDecoration(
        //     image: DecorationImage(
        //         image:image,fit: BoxFit.fill)),
      ),
    );
  }
}


class Settingmenupopup extends StatelessWidget {
  Settingmenupopup({super.key, this.radius = 8, required this.mdFilename})
      : assert(
  mdFilename.contains('.md'), 'The file must contain .md extension');

  final double radius;
  final String mdFilename;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape:
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
      child: Column(
        children: [
          Expanded(
              child: FutureBuilder(
                  future: Future.delayed(const Duration(microseconds: 150))
                      .then((value) =>
                      rootBundle.loadString('lib/assets/$mdFilename')),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Markdown(
                          styleSheet: MarkdownStyleSheet.fromTheme(ThemeData(
                              textTheme: TextTheme(
                                  bodyMedium: TextStyle(
                                      fontSize: 15.0, color: Colors.black)))),
                          data: snapshot.data.toString());
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  })),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  )),
              alignment: Alignment.center,
              height: 50,
              width: double.infinity,
              child: Text(
                'OK',
                style: TextStyle(color: Colors.black),
              ),
            ),
          )
        ],
      ),
    );
  }
}