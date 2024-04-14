// import 'dart:html';

// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ftp/LoginPage.dart';
import 'package:ftp/dbHandler.dart';
import 'package:ftp/userQrCodeScanner.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

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
  String? productIdvalue;
  String? role;
  String? production_mail;
  String? qc_mail;
  String? store_mail;
  TextEditingController remarkController = TextEditingController();

  String? username;
  String? CheckByUser_production;
  String? CheckByUser_QA;
  var userCompanyID;
  String? qa_status;
  var updateId;

  void initState() {
    barCodeValue = Get.arguments['barcode'];
    getvalue();
    super.initState();
  }

  void getvalue() async {
    await dbHandler().fetchdataProduct(barCodeValue).then(
      (value) async {
        late SharedPreferences spgetrole;
        spgetrole = await SharedPreferences.getInstance();

        setState(() {
          role = spgetrole.getString('role');
          username = spgetrole.getString('userprofilename');

          userCompanyID = spgetrole.getString('companyid');

          ScanValue = value;
          updateId = ScanValue != null ? ScanValue[0]['id'] ?? '' : '';

          productIdvalue =
              ScanValue != null ? ScanValue[0]['productId'] ?? '' : '';
// print(productIdvalue);
          productName =
              ScanValue != null ? ScanValue[0]['productName'] ?? '' : '';
          manufacturing =
              ScanValue != null ? ScanValue[0]['manufacturingPlant'] ?? '' : '';
          productDimension =
              ScanValue != null ? ScanValue[0]['productDiminsion'] ?? '' : '';
          description = ScanValue != null
              ? ScanValue[0]['productionDescription'] ?? ''
              : ' ';
          remark =
              ScanValue != null ? ScanValue[0]['productionReview'] ?? '' : ' ';

          CheckByUser_production = ScanValue != null
              ? ScanValue[0]['productionCheckUSerId'] ?? ''
              : ' ';
          // if(role=='QA/QC'){
          CheckByUser_QA = ScanValue != null
              ? ScanValue[0]['qualityCheckUserID'] ?? ''
              : ' ';
          qa_status = ScanValue != null
              ? ScanValue[0]['qualityCheckStatus'] ?? ''
              : ' ';
          // }
          getemailvalue();
        });
      },
    ).onError((error, stackTrace) {
      print(error);
    });
  }

  getemailvalue() async {
    await dbHandler()
        .fetchUseremailData(
            CheckByUser_production, CheckByUser_QA, userCompanyID)
        .then(
      (value) {
        print("inseide pdf");
        print(value);
        // print(value[0]['email']);
        production_mail = value[0]['email'].toString().trim();
        qc_mail = value[1]['email'].toString().trim();
        store_mail = value[2]['email'].toString().trim();
        print(production_mail);
        print(qc_mail);
        print(store_mail);
      },
    ).onError((error, stackTrace) {
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () async {},
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
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
          child: Column(
            children: [

Padding(
                        padding: EdgeInsetsDirectional.all(15),
                        child: Text(
                          '$productName',
                          style: TextStyle(
                            fontFamily: 'Readex Pro',
                            fontSize: 30,
                            letterSpacing: 0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

              Container(

height: 700,
                 decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(50),
                    topLeft: Radius.circular(50))),
                child: Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                    child: SingleChildScrollView(
                      child: Column(children: [
                        
                        Padding(
                          padding: EdgeInsetsDirectional.all(15),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
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
                                padding: EdgeInsetsDirectional.fromSTEB(120, 0, 0, 0),
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
                                padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                                child: Text(
                                  'ProductID',
                                  style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(120, 0, 0, 0),
                                child: Container(
                                  width: 120,
                                  // color: Colors.red,
                                  child: Text(
                                    '$productIdvalue',
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
                                padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
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
                                padding: EdgeInsetsDirectional.fromSTEB(70, 0, 0, 0),
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
                                padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
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
                                padding: EdgeInsetsDirectional.fromSTEB(80, 0, 0, 0),
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
                                padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
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
                                padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
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
                                  padding:
                                      EdgeInsetsDirectional.fromSTEB(110, 0, 0, 0),
                                  child: Container(
                                    // color: Colors.red,
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
                        role == 'Store'
                            ? Padding(
                                padding: EdgeInsetsDirectional.all(15),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                                      child: Text(
                                        'QA Check',
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
                                          // color: Colors.red,
                                          width: 150,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                '$qa_status',
                                                style: TextStyle(
                                                  fontFamily: 'Readex Pro',
                                                  letterSpacing: 0,
                                                ),
                                              ),
                                              Image.asset(
                                                "assets/images/checkmark.png",
                                                width: 20,
                                                height: 20,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : SizedBox(),
                        Padding(
                            padding: const EdgeInsets.only(top: 80),
                            child: role == 'Production'
                                ? SizedBox(
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
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SizedBox(
                                        width: 150,
                                        height: 50,
                                        child: ElevatedButton(
                                            onPressed: () async {
                
                
                                              
                                              role == 'Store'
                                                  ? await dbHandler()
                                                      .updataStore(
                                                        updateId,
                                                        remarkController.text,
                                                        "Approved",
                                                        userCompanyID,
                                                      )
                                                      .then((value) => null)
                                                  : await dbHandler()
                                                      .updataQA(
                                                        updateId,
                                                        remarkController.text,
                                                        "Approved",
                                                        userCompanyID,
                                                      )
                                                      .then((value) => null);
                
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
                              Future.delayed(Duration(seconds: 5), () {

                               Get.back();
                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      backgroundColor: Colors.white,
                                                      actions: <Widget>[
                                                        Container(
                                                          width: 500,
                                                          height: 300,
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              Image.asset(
                                                                "assets/images/donegif.gif",
                                                                width: 200,
                                                                height: 200,
                                                              ),
                                                              Text("Approved",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                                              SizedBox(
                                                                width: 200,
                                                                height: 50,
                                                                child: ElevatedButton(
                                                                    onPressed: () {
                                                                      Get.back();
                                                                    },
                                                                    style:
                                                                        ElevatedButton
                                                                            .styleFrom(
                                                                      backgroundColor:
                                                                          Colors.indigo[
                                                                              900], // Background color
                                                                    ),
                                                                    child: Text(
                                                                        "Done",
                                                                        style: TextStyle(
                                                                            color: Colors
                                                                                .white))),
                                                              )
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    );
                                                  });
                                                 
                                            
                              });
                 
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Colors.green, // Background color
                                            ),
                                            child: Text("Accept",
                                                style:
                                                    TextStyle(color: Colors.white))),
                                      ),
                                      SizedBox(
                                        width: 150,
                                        height: 50,
                                        child: ElevatedButton(
                                            onPressed: () {
                                              // Get.back();
                
                                              showModalBottomSheet(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return Container(
                                                    padding: EdgeInsets.all(20),
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment.stretch,
                                                      children: [
                                                        Align(
                                                            alignment:
                                                                Alignment.center,
                                                            child: Text(
                                                              'Are you sure?',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight.bold,
                                                                  fontSize: 20),
                                                            )),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            SizedBox(
                                                              width: 150,
                                                              height: 40,
                                                              child: ElevatedButton(
                                                                  onPressed: () {
                                                                                                                              Get.back();
                
                                                                    showDialog(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (context) {
                                                                          return AlertDialog(
                                                                            title:
                                                                                Align(
                                                                              alignment:
                                                                                  Alignment.center,
                                                                              child:
                                                                                  Text(
                                                                                'Remark',
                                                                                style:
                                                                                    TextStyle(
                                                                                  fontSize:
                                                                                      20.0,
                                                                                  fontWeight:
                                                                                      FontWeight.bold,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            actions: <Widget>[
                                                                              Container(
                                                                                width:
                                                                                    450,
                                                                                height:
                                                                                    190,
                                                                                child:
                                                                                    Column(
                                                                                
                                                                                  children: [
                                                                                    SizedBox(
                                                                                      child: TextField(
                                                                                        maxLines: 3,
                                                                                        controller: remarkController,
                                                                                        decoration: InputDecoration(
                                                                                          isDense: true,
                                                                                          hintText: "Describe the reasons for rejection ",
                                                                                          border: OutlineInputBorder(
                                                                                            borderSide: BorderSide(color: Colors.grey),
                                                                                            borderRadius: BorderRadius.circular(10),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    Padding(
                                                                                      padding: const EdgeInsets.all(15),
                                                                                      child: SizedBox(
                                                                                        width: 200,
                                                                                        height: 50,
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
                                                                                                        child: LoadingAnimationWidget.discreteCircle(
                                                                                                          color: Colors.white,
                                                                                                          size: 50,
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  );
                                                                                                },
                                                                                              );
                
                                                                                             
                  getemailvalue();
                                                                                             
                
                                                                                              //  Get.back();
                                                                                              Future.delayed(Duration(seconds: 3), () {
                  
                    Send_mail();
                 final snackBar=SnackBar(
                  content: const Text("Please Wait "),
                  action: SnackBarAction(
                    label: 'Sending Mail',
                    onPressed: () {
                      // Some code to undo the change.
                    },
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                                                                              });
                                                                                                                                                                                      Get.back();
                
                                                                                             
                
                                                                                            },
                                                                                            
                                                                                            style: ElevatedButton.styleFrom(
                                                                                              backgroundColor: Colors.indigo[900], 
                                                                                            ),
                                                                                            child: Text("Send Mail", style: TextStyle(color: Colors.white))),
                                                                                      ),
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                              )
                                                                            ],
                                                                          );
                                                                        });
                                                                  },
                                                                  style: ElevatedButton
                                                                      .styleFrom(
                                                                          shape:
                                                                              LinearBorder()
                // Background color
                                                                          ),
                                                                  child: Icon(
                                                                      Icons.done)),
                                                            ),
                                                            SizedBox(
                                                              width: 150,
                                                              height: 50,
                                                              child: ElevatedButton(
                                                                  onPressed: () {
                                                                  Get.back();
                                                                  },
                                                                  style: ElevatedButton.styleFrom(
                                                                      shape:
                                                                          LinearBorder()
                                                                     
                                                                      ),
                                                                  child: Icon(
                                                                      Icons.cancel)),
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Colors.red, // Background color
                                            ),
                                            child: Text("Reject",
                                                style:
                                                    TextStyle(color: Colors.white))),
                                      ),
                                    ],
                                  ))
                      ]),
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
 void cnf(){
   showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                actions: <Widget>[
                  Container(
                    width: 500,
                    height: 300,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                          "assets/images/donegif.gif",
                          width: 200,
                          height: 200,
                        ),
                        Text(
                          "Email Sent Successfully",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 200,
                          height: 50,
                          child: ElevatedButton(
                              onPressed: () {
                                  Get.back();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Colors.indigo[900], // Background color
                              ),
                              child: Text("OK",
                                  style: TextStyle(color: Colors.white))),
                        )
                      ],
                    ),
                  )
                ],
              );
            });
 }














  void Send_mail() {
    // var Service_id = 'service_wv0fuqf',
    //     Template_id = 'template_cnk3plf',
    //     User_id = 'Fi_N4AtsfrugumPNL';
    // print("$production_mail " + "inside");
    // print(productId);
    // print(qc_mail);
    var s = http
        .post(Uri.parse('https://api.emailjs.com/api/v1.0/email/send'),
            headers: {
              'origin': 'http:localhost',
              'Content-Type': 'application/json'
            },
            body: jsonEncode({
              'service_id': 'service_wv0fuqf',
              'user_id': 'Fi_N4AtsfrugumPNL',
              'template_id': 'template_cnk3plf',
              'template_params': {
                // 'reply_to_cc': "deekanojiya@gmail.com",
                'reply_to_BCC': role == 'Store' ? qc_mail : '',
                'to_name': role,
                'reply_to': role == 'Store' ? store_mail : qc_mail,
                'ProductName_head': productName,
                'from_Departmentname': role,
                'barcodeno': barCodeValue,
                'ProductID': productIdvalue,
                'ProuductName': productName,
                'remark': remarkController.text,
                'to_email': production_mail,
                'from_Department': role,
              }
            }))
        .then((response) {
      // Handle the response here
      print('Status code: ${response.statusCode}');
      if (response.statusCode == 200) {
        print('Email sent successfully');
               Get.back();

        cnf();
      } else {
        // Request failed
        print('Failed to send email. Status code: ${response.statusCode}');
      }
    });
    
    // Get.back();
    // print(productName);
  }

}
