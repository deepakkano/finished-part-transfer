import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ftp/LoginPage.dart';
import 'package:ftp/dbHandler.dart';
import 'package:ftp/showAllValue.dart';
import 'package:ftp/userQrCodeScanner.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BarcodePage extends StatefulWidget {
  const BarcodePage({super.key});

  @override
  State<BarcodePage> createState() => _BarcodePageState();
}

class _BarcodePageState extends State<BarcodePage> {
  var username;
  var userCompanyID;
  @override
  void initState() {
    fetchsingleuser();
    super.initState();
  }
  void fetchsingleuser() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    userCompanyID = sharedPref.getString('companyid');

    await dbHandler().fetchUserSingleData(userCompanyID).then((value) {
      setState(() {
        username = value != null ? value[0]['name'] ?? '' : '';
        sharedPref.setString("userprofilename", username);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () async {
                  Get.to(ShowAllValue());
                },
                icon: Icon(
                  Icons.remove_red_eye,
                  color: Colors.white,
                )),
            IconButton(
                onPressed: () async {
                  late SharedPreferences spget;
                  spget = await SharedPreferences.getInstance();
                  spget.setBool('login_flag', true);

                  Get.offAll(LoginPage());
                },
                icon: Icon(
                  Icons.exit_to_app,
                  color: Colors.white,
                ))
          ],
          backgroundColor: Colors.blue,
          title: Text(
            '$username',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
        body: Container(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  child: Column(
                    children: [
                      Text(
                        "Click the Scan Qr Button on the Bottom",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                          "Position your QR code in front. Scanner will scan it automatically"),
                    ],
                  ),
                ),
                Image.asset(
                  "assets/images/qr.png",
                  width: 200,
                  height: 200,
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Container(
                    width: 350,
                    height: 50,
                    decoration: BoxDecoration(
                        // color: Color.fromARGB(255, 75, 57, 239),
                        borderRadius: BorderRadius.circular(20),
                        border: Border()),
                    child: ElevatedButton(
                        onPressed: () {
                          showModalBottomSheet<void>(
                            context: context,
                            backgroundColor: Colors.transparent,
                            builder: (BuildContext context) {
                              return Padding(
                                padding: const EdgeInsets.all(200),
                                child: Center(
                                  child: Container(
                                    width: double.infinity,
                                    height: double.infinity,
                                    color: Colors.transparent,
                                    child:
                                        LoadingAnimationWidget.discreteCircle(
                                      color: Colors.white,
                                      size: 50,
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                          Future.delayed(Duration(seconds: 3), () {
                            Get.to(UserQrCodeScanner());
                          });
                        },
                        child: Text(
                          "Scan Qr",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 75, 57, 239),
                          // shape: RoundedRectangleBorder()
                        )),
                  ),
                )
              ],
            )));
  }
}
