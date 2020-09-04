import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocerydistributorapp/Classes/Constants.dart';
import 'package:grocerydistributorapp/Screens/LoginPage.dart';
import 'package:grocerydistributorapp/Screens/MyShops.dart';
import 'package:grocerydistributorapp/Screens/SendInvites.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final pHeight = MediaQuery.of(context).size.height;
    final pWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        backgroundColor: kSecondaryColor,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.power_settings_new,
              color: kSecondaryColor,
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                'Grocery Distributor App',
                style: GoogleFonts.poppins(
                  textStyle:
                      TextStyle(color: Colors.white, fontSize: pHeight * 0.025),
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.power_settings_new,
              color: Colors.white,
            ),
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),
              );
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => MyShops(),
                    ),
                  );
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: kSecondaryColor,
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Container(
                      width: double.infinity,
                      child: Column(
                        children: <Widget>[
                          Image.asset(
                            'images/shop(1).png',
                            scale: 3.25,
                          ),
                          SizedBox(
                            height: pHeight * 0.01,
                          ),
                          Text(
                            'My referred shops',
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: pHeight * 0.025,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => SendInvites(),
                    ),
                  );
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: kSecondaryColor,
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Container(
                      width: double.infinity,
                      child: Column(
                        children: <Widget>[
                          Image.asset(
                            'images/heart.png',
                            scale: 3.25,
                          ),
                          SizedBox(
                            height: pHeight * 0.01,
                          ),
                          Text(
                            'Send Invites',
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: pHeight * 0.025,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: kSecondaryColor,
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Container(
                      width: double.infinity,
                      child: Column(
                        children: <Widget>[
                          Image.asset(
                            'images/contact-us.png',
                            scale: 3.25,
                          ),
                          SizedBox(
                            height: pHeight * 0.01,
                          ),
                          Text(
                            'Contact Us',
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: pHeight * 0.025,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
