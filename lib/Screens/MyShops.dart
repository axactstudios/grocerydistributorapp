import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocerydistributorapp/Classes/Constants.dart';
import 'package:grocerydistributorapp/Classes/Shops.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyShops extends StatefulWidget {
  @override
  _MyShopsState createState() => _MyShopsState();
}

class _MyShopsState extends State<MyShops> {
  List<Shops> shops = [];
  bool isFetching = false;

  void getShops() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String ref = await prefs.getString('referral');
    shops.clear();
    setState(() {
      isFetching = true;
    });
    final dbRef = FirebaseDatabase.instance
        .reference()
        .child('Distributors')
        .child(ref)
        .child('Shops');
    dbRef.once().then((DataSnapshot snap) {
      Map<dynamic, dynamic> values = snap.value;
      values.forEach((key, value) async {
        Shops newShop = Shops();
        newShop.shopKey = key;
        newShop.shopName = await value['shopName'];
        newShop.shopPhone = await value['shopPhone'];
        newShop.shopAddress = await value['shopAddress'];
        newShop.shopUid = await value['shopUid'];
        shops.add(newShop);
      });
      setState(() {
        print('Shops fetched');
        isFetching = false;
      });
    });
  }

  @override
  void initState() {
    getShops();
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
                  'Shops Referred',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: Colors.white, fontSize: pHeight * 0.025),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: isFetching
            ? Center(
                child: SpinKitFadingFour(
                  color: kSecondaryColor,
                ),
              )
            : (shops.length == 0
                ? Center(
                    child: Text(
                      'No shops have yet accepted your invite.',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: kSecondaryColor, fontSize: pHeight * 0.025),
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                        itemCount: shops.length,
                        itemBuilder: (context, index) {
                          var item = shops[index];
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            color: kSecondaryColor,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Container(
                                width: double.infinity,
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      'Shop ${index + 1}',
                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            color: Colors.white,
                                            fontSize: pHeight * 0.025),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            child: Text(
                                              'Shop Name :',
                                              style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: pHeight * 0.02),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            child: Text(
                                              item.shopName,
                                              textAlign: TextAlign.end,
                                              style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: pHeight * 0.02),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            child: Text(
                                              'Shop Phone :',
                                              style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: pHeight * 0.02),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            child: Text(
                                              item.shopPhone,
                                              textAlign: TextAlign.end,
                                              style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: pHeight * 0.02),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            child: Text(
                                              'Shop Address :',
                                              style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: pHeight * 0.02),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            child: Text(
                                              item.shopAddress,
                                              textAlign: TextAlign.end,
                                              style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: pHeight * 0.02),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  )));
  }
}
