import 'package:flutter/material.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocerydistributorapp/Classes/Constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SendInvites extends StatefulWidget {
  @override
  _SendInvitesState createState() => _SendInvitesState();
}

class _SendInvitesState extends State<SendInvites> {
  String referral = '';

  void getCode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String ref = await prefs.getString('referral');
    setState(() {
      referral = ref;
      print(referral);
    });
  }

  @override
  void initState() {
    getCode();
  }

  @override
  Widget build(BuildContext context) {
    final pHeight = MediaQuery.of(context).size.height;
    final pWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        backgroundColor: kSecondaryColor,
        actions: <Widget>[
          Expanded(
            child: Center(
              child: Text(
                'Send Invites',
                style: GoogleFonts.poppins(
                  textStyle:
                      TextStyle(color: Colors.white, fontSize: pHeight * 0.025),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              FlutterOpenWhatsapp.sendSingleMessage('',
                  'Register your shop on GroceryApp using my referral code *$referral*');
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: kSecondaryColor,
              child: Container(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'Your referral code is\n',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: Colors.white, fontSize: pHeight * 0.025),
                        ),
                      ),
                      Text(
                        referral,
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: pHeight * 0.035,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Text(
                        '\nAsk others to enter this code while registering their shops with us.\n\nThe referral code is case-sensitive.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: Colors.white, fontSize: pHeight * 0.025),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
