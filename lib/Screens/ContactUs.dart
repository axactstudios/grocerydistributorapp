import 'package:call_number/call_number.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocerydistributorapp/Classes/Constants.dart';
import 'package:intent/extra.dart';
import 'package:intent/intent.dart' as intent;
import 'package:intent/action.dart' as action;

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
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
                'Contact Us',
                style: GoogleFonts.poppins(
                  textStyle:
                      TextStyle(color: Colors.white, fontSize: pHeight * 0.025),
                ),
              ),
            ),
          ),
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
                onTap: () async {
                  await new CallNumber().callNumber('+919027553376');
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
                            'images/phone.png',
                            scale: 3.25,
                          ),
                          SizedBox(
                            height: pHeight * 0.01,
                          ),
                          Text(
                            'Phone',
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
                onTap: () async {
                  final Email email = Email(
                    body: 'Write your message',
                    subject: 'Grocery distributor app',
                    recipients: ['vkumarsaraswat@gmail.com'],
                    isHTML: false,
                  );

                  await FlutterEmailSender.send(email);
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
                            'images/gmail.png',
                            scale: 3.25,
                          ),
                          SizedBox(
                            height: pHeight * 0.01,
                          ),
                          Text(
                            'E-mail',
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
                  FlutterOpenWhatsapp.sendSingleMessage(
                      "919027553376", "Hello");
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
                            'images/whatsapp.png',
                            scale: 3.25,
                          ),
                          SizedBox(
                            height: pHeight * 0.01,
                          ),
                          Text(
                            'WhatsApp',
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
