import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocerydistributorapp/Classes/Constants.dart';
import 'package:grocerydistributorapp/Screens/HomePage.dart';
import 'package:regexed_validator/regexed_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  FirebaseAuth mAuth = FirebaseAuth.instance;
  TextEditingController email = new TextEditingController(text: '');
  TextEditingController pw = new TextEditingController(text: '');
  bool isObscured = true;

  @override
  Widget build(BuildContext context) {
    final pHeight = MediaQuery.of(context).size.height;
    final pWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'images/shop(1).png',
                scale: 2.5,
              ),
              SizedBox(
                height: pHeight * 0.02,
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Email address',
                  fillColor: kFormColor,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  hintStyle: GoogleFonts.poppins(
                    textStyle: TextStyle(color: kSecondaryColor),
                  ),
                  filled: true,
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                controller: email,
                validator: (value) {
                  if (!validator.email(value)) {
                    return 'Invalid email';
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: pHeight * 0.02,
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Password',
                  fillColor: kFormColor,
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  hintStyle: GoogleFonts.poppins(
                    textStyle: TextStyle(color: kSecondaryColor),
                  ),
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  suffixIcon: isObscured
                      ? IconButton(
                          icon: Icon(
                            Icons.visibility,
                            color: kSecondaryColor,
                          ),
                          onPressed: () {
                            setState(() {
                              isObscured = false;
                            });
                          },
                        )
                      : IconButton(
                          icon: Icon(Icons.visibility_off),
                          color: kSecondaryColor,
                          onPressed: () {
                            setState(() {
                              isObscured = true;
                            });
                          },
                        ),
                ),
                controller: pw,
                obscureText: isObscured,
                validator: (value) {
                  if (value.length < 6) {
                    return 'Invalid password';
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: pHeight * 0.02,
              ),
              RaisedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    signIn();
                  }
                },
                color: kSecondaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    'Sign in',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: kFormColor, fontSize: pHeight * 0.025),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void signIn() async {
    mAuth
        .signInWithEmailAndPassword(email: email.text, password: pw.text)
        .then((AuthResult) async {
      print('Logged in');
      User user = mAuth.currentUser;
      print(user.uid);

      var dbRef = FirebaseDatabase.instance.reference().child('Distributors');
      dbRef.once().then((DataSnapshot snap) async {
        Map<dynamic, dynamic> values = snap.value;
        values.forEach((key, value) async {
          String em = await value['email'];
          print(em);
          if (em == email.text) {
            print('key found');
            print(key);
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('referral', key);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
          }
        });
      });
    }).catchError((err) {
      if (err == "ERROR_USER_NOT_FOUND") {
        showCupertinoDialog(
            context: context,
            builder: (context) {
              return CupertinoAlertDialog(
                title: Text(
                    'This email is not yet registered. Please sign up first.'),
                actions: <Widget>[
                  CupertinoDialogAction(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              );
            });
      }
      if (err == "ERROR_WRONG_PASSWORD") {
        showCupertinoDialog(
            context: context,
            builder: (context) {
              return CupertinoAlertDialog(
                title:
                    Text('Wrong password. Please enter the correct password.'),
                actions: <Widget>[
                  CupertinoDialogAction(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              );
            });
      }
      if (err == "ERROR_NETWORK_REQUEST_FAILED") {
        showCupertinoDialog(
            context: context,
            builder: (context) {
              return CupertinoAlertDialog(
                title: Text(
                    'Your internet connection is either too slow or not available.'),
                actions: <Widget>[
                  CupertinoDialogAction(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              );
            });
      }
    });
  }
}
