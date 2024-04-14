// ignore_for_file: prefer_const_constructors

import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ftp/LoginPage.dart';
import 'package:ftp/dbHandler.dart';
import 'package:ftp/displayProductDetails.dart';
import 'package:ftp/editPageUser.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_scanner_overlay/qr_scanner_overlay.dart';
import 'package:shared_preferences/shared_preferences.dart';

const bg_color = Color(0xfffafafa);
bool isloading = false;

class UserQrCodeScanner extends StatefulWidget {
  const UserQrCodeScanner({super.key});

  @override
  State<UserQrCodeScanner> createState() => _UserQrCodeScannerState();
}

class _UserQrCodeScannerState extends State<UserQrCodeScanner> {
  @override
  MobileScannerController cameraController = MobileScannerController();
  bool _screenOpened = false;
  String? productNameValue;
  String? role;
  String? code;
  @override
  void initState() {
    getuserrole();
    super.initState();
  }

  void getuserrole() async {
    late SharedPreferences spgetrole;
    spgetrole = await SharedPreferences.getInstance();
    setState(() {
      role = spgetrole.getString('role');
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: bg_color,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.blue,
          actions: [
            IconButton(
                onPressed: () async {
                  late SharedPreferences spget;
                  spget = await SharedPreferences.getInstance();
                  spget.setBool('login_flag', true);
                  role = spget.getString('role');

                  Get.offAll(LoginPage());
                },
                icon: Icon(
                  Icons.logout,
                  color: Colors.white,
                ))
          ],
          title: Padding(
            padding: const EdgeInsets.only(left: 130),
            child: Text(
              "QrCode Scanner ",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ),
        body: Container(
          // color: Colors.red,
          width: double.infinity,
          padding: EdgeInsets.all(5),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                    // flex: 2,
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Place the Qr code in the Area",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1),
                    ),
                    Text(
                      "Scanning will be Started Automatically",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                )),
              ),
              Expanded(
                // flex: 2,
                // child: SizedBox(
                // width:200,
                // height: 200,
                child: Stack(
                  children: [
                    MobileScanner(
                      allowDuplicates: false,
                      controller: cameraController,
                      onDetect: _foundBarcode,
                    ),
                    QRScannerOverlay(overlayColor: bg_color)
                  ],
                ),
              ),
              Expanded(
                  child: Container(
                width: double.infinity,
                height: 200,
                // color: Colors.grey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    code == null
                        ? SizedBox(
                            child: Text(
                              "Scan Data Will Display Here",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          )
                        : Column(
                            children: [
                              Text("BarcodeNo",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              Text('$code'),
                              Text("ProductName",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              Text('$productNameValue'),
                              Padding(
                                padding: const EdgeInsets.all(15),
                                child: SizedBox(
                                  width: 250,
                                  height: 50,
                                  child: ElevatedButton(
                                      onPressed: () async {
                                        showModalBottomSheet<void>(
                                          context: context,
                                          backgroundColor: Colors.transparent,
                                          builder: (BuildContext context) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(200),
                                              child: Center(
                                                child: Container(
                                                  width: double.infinity,
                                                  height: double.infinity,
                                                  color: Colors.transparent,
                                                  child: LoadingAnimationWidget
                                                      .discreteCircle(
                                                    color: Colors.white,
                                                    size: 50,
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                        Future.delayed(Duration(seconds: 5),
                                            () {
                                              Get.back();
                                          role == 'Production'
                                              ? Get.to(EditPageUser(),
                                                  arguments: {'barcode': code})
                                              : Get.to(DisplayProductDetails(),
                                                  arguments: {'barcode': code});
                                                
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors
                                            .indigo[900], // Background color
                                      ),
                                      child:role=='Production'?Text("Edit", style:
                                              TextStyle(color: Colors.white)):Text("Verify", style:
                                              TextStyle(color: Colors.white))
                                         )),
                                ),
                              
                            ],
                          ),
                  ],
                ),
              )),
            ],
          ),
        ));
  }

  void _foundBarcode(Barcode barcode, MobileScannerArguments? args) async {
    if (!_screenOpened) {
      code = barcode.rawValue ?? "---";
      _screenOpened = true;
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
                child: LoadingAnimationWidget.discreteCircle(
                  color: Colors.white,
                  size: 50,
                ),
              ),
            ),
          );
        },
      );
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          debugPrint('Barcode found! $code');
          fetch_value();
        });
        Navigator.pop(context);
      });
    }
  }

  void fetch_value() async {
    await dbHandler().fetchdataProduct(code).then((value) {
      var productdesc;
       String CheckCode='';
      setState(() {
        CheckCode = value[0]['barCodeNo'];
        productNameValue = value[0]['productName'];
        productdesc = value[0]['productionDescription'];
        // print(productdesc);
        // print(role);
      });

      if (role != 'Production' && productdesc == null) {
       setState(() {
        code = null;
      });
        showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Padding(
            padding: const EdgeInsets.all(5),
            child: Container(
              width: 350,
              height: 80,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                 
                  Icon(Icons.info, size: 40, color: Colors.red),
                  Text(
                    CheckCode,
                    style: TextStyle(fontSize: 20, color: Colors.red),
                  ),
                ],
              ),
            ),
          ),
          content: Padding(
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Unauthorized Barcode Number',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          actions: <Widget>[
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                            width: 200,
                            height: 50,
                            child: ElevatedButton(
                                onPressed: () {
              setState(() {
                    _screenOpened = false;
                  });
              
                  Get.back();                              },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Colors.indigo[900], // Background color
                                ),
                                child: Text("OK",
                                    style: TextStyle(color: Colors.white))),
                          ),
            ),
          ],
        ),
      );
      }
      else{
        print(role);
      }
    }).onError((error, stackTrace) {
      setState(() {
        code = null;
      });
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Padding(
            padding: const EdgeInsets.all(5),
            child: Container(
              width: 200,
              height: 80,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Icon(Icons.info, size: 40, color: Colors.red),
                  Text(
                    'Alert',
                    style: TextStyle(fontSize: 20, color: Colors.red),
                  ),
                ],
              ),
            ),
          ),
          content: Padding(
            padding: const EdgeInsets.all(10),
            child: const Text(
              'BarCode Not Found.Try Again',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          actions: <Widget>[
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                            width: 200,
                            height: 50,
                            child: ElevatedButton(
                                onPressed: () {
              setState(() {
                    _screenOpened = false;
                  });
              
                  Get.back();                              },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Colors.indigo[900], // Background color
                                ),
                                child: Text("OK",
                                    style: TextStyle(color: Colors.white))),
                          ),
            ),
          ],
        ),
      );
    });
  }

  void _screenWasClosed() {
    _screenOpened = false;
  }
}
