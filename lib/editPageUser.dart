// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ftp/LoginPage.dart';
import 'package:ftp/dbHandler.dart';
import 'package:ftp/displayProductDetails.dart';
import 'package:ftp/modelClass/db_model.dart';
import 'package:ftp/userQrCodeScanner.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditPageUser extends StatefulWidget {
  const EditPageUser({super.key});

  @override
  State<EditPageUser> createState() => _EditPageUserState();
}

class _EditPageUserState extends State<EditPageUser> {
   var ScanValue;
  var barCodeValue;
  TextEditingController? productNameController;
    TextEditingController? manufacturingController;
  TextEditingController? productDimensionController;
  TextEditingController? descriptionController;
  TextEditingController? remarkController;
  var updateId;
var userCompanyID;

  @override
  void initState() {
    barCodeValue = Get.arguments['barcode'];
    // barCodeValue='';
    getvalue();
    super.initState();
  }
  checkuserid()async{
     SharedPreferences sharedPref = await SharedPreferences.getInstance();
    userCompanyID = sharedPref.getString('companyid');
  }
 void getvalue() async {
  
    await dbHandler().fetchdataProduct(barCodeValue).then(
      (value) {
        
        setState((){
          checkuserid();
          ScanValue = value;
          updateId=ScanValue != null ? ScanValue[0]['id'] ?? '' : '';
              productNameController = TextEditingController(
              text: ScanValue != null ? ScanValue[0]['productName'] ?? '' : ''); 
              manufacturingController = TextEditingController(
              text: ScanValue != null ? ScanValue[0]['manufacturingPlant'] ?? '' : '');
              productDimensionController = TextEditingController(
              text: ScanValue != null ? ScanValue[0]['productDiminsion'] ?? '' : '');
              descriptionController = TextEditingController(
              text: ScanValue != null ? ScanValue[0]['productionDescription'] ?? '' : ' ');
              remarkController = TextEditingController(
              text: ScanValue != null ? ScanValue[0]['productionReview'] ?? '' : ' ');
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
                  automaticallyImplyLeading: false,

        backgroundColor: Colors.blue,
       
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
          ], title: Text(
            "Chirag",
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: SingleChildScrollView(
          child: Column(
            children: [
               Align(
          alignment: Alignment.center,
            child: Text(
                  "Product ",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.black),
                ),
          ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "BarCodeNO",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w100),
                    )),
              ),
              SizedBox(
                height: 50,
                child: TextField(
                  readOnly: true,
                  controller: TextEditingController(text: barCodeValue),
                  decoration: InputDecoration(
                    isDense: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Product Name",
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w100),
                    )),
              ),
              SizedBox(
                height: 50,
                child: TextField(
                  readOnly: true,
                  controller: productNameController,
                  decoration: InputDecoration(
                    isDense: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Manufacturing Plant",
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w100),
                    )),
              ),
              SizedBox(
                height: 50,
                child: TextField(
                  readOnly: true,
                  controller: manufacturingController,
                  // obscureText: true,s
                  decoration: InputDecoration(
                    isDense: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Product Dimension",
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w100),
                    )),
              ),
              SizedBox(
                height: 50,
                child: TextField(
                  readOnly: true,
                  controller: productDimensionController,
                  decoration: InputDecoration(
                    isDense: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Description",
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w100),
                    )),
              ),
              SizedBox(
                child: TextField(
                  maxLines: 5,
                  controller: descriptionController,
                      
                  decoration: InputDecoration(
                    isDense: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Remark *",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w100,
                          color: Colors.red),
                    )),
              ),
              SizedBox(
                height: 50,
                child: TextField(
                  // readOnly: true,
                  controller: remarkController,

                  decoration: InputDecoration(
                    isDense: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 80),
                child: SizedBox(
                  width: 250,
                                                    height: 50,
                
                  child: ElevatedButton(onPressed: () async{
                
                    if (descriptionController != null && remarkController != null) {
                    await dbHandler().updataproduct(
                      updateId,
                      descriptionController!.text,
                      remarkController!.text,
                      userCompanyID,

                      
                    ).then((value) {
                      // Handle the result if needed
                    }
                    
                    
                    );
                  }
                
                Get.to(DisplayProductDetails(),arguments: {
                'barcode':barCodeValue
                });
                
                
                
                  },style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Colors.indigo[900], // Background color
                                    ), child: Text("Save",style: TextStyle(color: Colors.white))),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
