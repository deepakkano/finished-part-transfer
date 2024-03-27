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
          width: double.infinity,
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Place the Qr code in the Area",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,letterSpacing: 1),
                  ),
                  Text(
                    "Scanning will be Started Automatically",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              )),
              Expanded(
                  flex: 4,
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
                 QRScannerOverlay(
                    overlayColor: bg_color
                    )
                  ],
                ),
              ),
              Expanded(
                  child: Container(
                width: double.infinity,
                // color: Colors.grey,
                child: Column(
                  children: [
                    code == null
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
                  Get.to(EditPageUser(),arguments: {
                    'barcode':code
                  });
                },
                                  child: Text("Edit"))
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
        _screenOpened = false;
      });
    }
    
   
  }

  void _screenWasClosed() {
    _screenOpened = false;
  }
}
