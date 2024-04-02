// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:ftp/dbHandler.dart';
import 'package:ftp/editPageUser.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_scanner_overlay/qr_scanner_overlay.dart';

const bg_color = Color(0xfffafafa);

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
  String? code;
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bg_color,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          title: Align(
              alignment: Alignment.center,
              child: Text(
                "QrCode Scanner ",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )),
        ),
        body: Container(
          // color: Colors.red,
          width: double.infinity,
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Expanded(
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
             Expanded(
                  // flex: 3,
                  // child: SizedBox(
                  // width:200,
                  // height: 200,
                  child: Stack(
                    children: [
                      SizedBox(
                         width: 250,
                  height: 250,
                        child: MobileScanner(
                          allowDuplicates: false,
                          controller: cameraController,
                          onDetect: _foundBarcode,
                        ),
                      ),
                      QRScannerOverlay(overlayColor: bg_color)
                    ],
                  ),
                ),
              
              Expanded(
                  child: Container(
                width: double.infinity,
                // color: Colors.grey,
                child: Column(
                  children: [
                    code != null
                        ? SizedBox(
                            child: Text("Scan Data Will Display Here"),
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
                              ElevatedButton(
                                  onPressed: () async {
                                    Get.to(EditPageUser(),
                                        arguments: {'barcode': code});
                                  },style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Colors.indigo[900], // Background color
                              ),
                                  child: Text("Edit", style: TextStyle(color: Colors.white)))
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
      setState(() {
        debugPrint('Barcode found! $code');
        fetch_value();

        _screenOpened = false;
      });
    }
  }

  void fetch_value() async {
    await dbHandler().fetchdataProduct(code).then((value) {
      setState(() {
        String CheckCode = value[0]['barCodeNo'];

        productNameValue = value[0]['productName'];
      });
    }).onError((error, stackTrace) {
      setState(() {
        code = null;
      });
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Container(
            width: 350,
            height: 100,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.blue,
            ),
            // color: Colors.yellow,
            child: Row(
              children: [
                Icon(Icons.info, size: 40, color: Colors.red),
                SizedBox(width: 8),
                Text(
                  'Alert',
                  style: TextStyle(fontSize: 18, color: Colors.red),
                ),
              ],
            ),
          ),
          content: const Text('BarCode Not Found.Try Again'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Get.back(),
              child: const Text('ok'),
            ),
            // TextButton(
            //   onPressed: () => Navigator.pop(context, 'OK'),
            //   child: const Text('OK'),
            // ),
          ],
        ),
      );
    });
  }

  void _screenWasClosed() {
    _screenOpened = false;
  }
}
