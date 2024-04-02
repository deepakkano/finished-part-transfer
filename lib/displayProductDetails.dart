// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:ftp/dbHandler.dart';
import 'package:ftp/userQrCodeScanner.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class DisplayProductDetails extends StatefulWidget {
  const DisplayProductDetails({super.key});

  @override
  State<DisplayProductDetails> createState() => _DisplayProductDetailsState();
}

class _DisplayProductDetailsState extends State<DisplayProductDetails> {
  var ScanValue;
  var barCodeValue;
  String? productName;
  String? manufacturing;
  String? productDimension;
  String? description;
  String? remark;
  void initState() {
    barCodeValue = Get.arguments['barocodevalue'];
    getvalue();
    super.initState();
  }

  void getvalue() async {
    await dbHandler().fetchdataProduct(barCodeValue).then(
      (value) {
        setState(() {
          ScanValue = value;

          productName =
              ScanValue != null ? ScanValue[0]['productName'] ?? '' : '';
          manufacturing =
              ScanValue != null ? ScanValue[0]['manufacturingPlant'] ?? '' : '';
          productDimension =
              ScanValue != null ? ScanValue[0]['productDiminsion'] ?? '' : '';
          description =
              ScanValue != null ? ScanValue[0]['Description'] ?? '' : ' ';
          remark = ScanValue != null ? ScanValue[0]['Review'] ?? '' : ' ';
        });
      },
    ).onError((error, stackTrace) {
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ))
        ],
        backgroundColor: Colors.blue,
        title: Text(
          "Product Information",
          style: TextStyle(fontSize: 25, color: Colors.white),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
          child: Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
              child: SingleChildScrollView(
                child: Column(
                    // mainAxisSize: MainAxisSize.max,
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.all(15),
                        child: Text(
                          '$productName',
                          style: TextStyle(
                            fontFamily: 'Readex Pro',
                            fontSize: 20,
                            letterSpacing: 0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.all(15),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                              child: Text(
                                'BarCode No',
                                style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(120, 0, 0, 0),
                              child: Container(
                                width: 120,
                                // color: Colors.red,
                                child: Text(
                                  '$barCodeValue',
                                  style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    letterSpacing: 0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.all(15),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                              child: Text(
                                'ManufacturingPlant',
                                style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(70, 0, 0, 0),
                              child: Container(
                                width: 100,
                                child: Text(
                                  '$manufacturing',
                                  style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    letterSpacing: 0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.all(15),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                              child: Text(
                                'ProductDiminsion',
                                style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(80, 0, 0, 0),
                              child: Container(
                                width: 100,
                                child: Text(
                                  '$productDimension',
                                  style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    letterSpacing: 0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.all(15),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                              child: Text(
                                'Description',
                                style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Flexible(
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(80, 0, 0, 0),
                                child: Container(
                                  width: 150,
                                  child: Text(
                                    '$description',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontFamily: 'Readex Pro',
                                      letterSpacing: 0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.all(15),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                              child: Text(
                                'Remark',
                                style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Flexible(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    110, 0, 0, 0),
                                child: Container(
                                  color: Colors.red,
                                  width: 150,
                                  child: Text(
                                    '$remark',
                                    style: TextStyle(
                                      fontFamily: 'Readex Pro',
                                      letterSpacing: 0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 150),
                        child: SizedBox(
                          width: 200,
                          height: 50,
                          child: ElevatedButton(
                              onPressed: () {
                                Get.to(UserQrCodeScanner());
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Colors.indigo[900], // Background color
                              ),
                              child: Text("Scan",
                                  style: TextStyle(color: Colors.white))),
                        ),
                      )
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
