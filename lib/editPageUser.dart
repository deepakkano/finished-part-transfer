// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ftp/dbHandler.dart';
import 'package:ftp/modelClass/db_model.dart';
import 'package:ftp/userQrCodeScanner.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class EditPageUser extends StatefulWidget {
  const EditPageUser({super.key});

  @override
  State<EditPageUser> createState() => _EditPageUserState();
}

class _EditPageUserState extends State<EditPageUser> {

@override
 
 
  void getvalue ()async{
final data = await dbHandler().fetchData('$barCodeValue');

// print("kajfkahfakndandknsakjflsafjbsaklfbhjlfbaslfsadlfslfjsf,n");
   var   productNameValue = data['productNameValue'];
   var  manufacturingPlant=data['manufacturingPlantValue'];
      var productDiminsionValue = data['productDiminsionValue'];
   var  Description=data['Description'];
      var Review = data['Review'];
  }

  TextEditingController productName = TextEditingController();
  TextEditingController manufacturingPlant = TextEditingController();
  TextEditingController productDiminsion = TextEditingController();
    TextEditingController Description = TextEditingController();
  TextEditingController Review = TextEditingController();

  var barCodeValue = Get.arguments[0]['barcodeno'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
              onPressed: () {
                Get.to(UserQrCodeScanner());
              },
              icon: Icon(Icons.qr_code_scanner_outlined)),
          IconButton(onPressed: () {}, icon: Icon(Icons.logout)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: SingleChildScrollView(
          child: Column(
            
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
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
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Product Name",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w100),
                  )),
              SizedBox(
                height: 50,
                child: TextField(
                  readOnly: true,
                                    controller: productName,

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
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Manufacturing Plant",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w100),
                  )),
              SizedBox(
                height: 50,
                child: TextField(
                  readOnly: true,
                  // controller: TextEditingController(text: barCodeValue),
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
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Product Dimension",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w100),
                  )),
              SizedBox(
                height: 50,
                child: TextField(
                  readOnly: true,
                  // controller: TextEditingController(text: barCodeValue),
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
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Diminsion",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w100),
                  )),
              SizedBox(
                child: TextField(
                  maxLines: 5,
                  decoration: InputDecoration(
                    isDense: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Remark *",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w100,
                        color: Colors.red),
                  )),
              SizedBox(
                height: 50,
                child: TextField(
                  // readOnly: true,
                  // controller: TextEditingController(text: barCodeValue),
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
              SizedBox(
                width: 200,
                child: ElevatedButton(onPressed: () {}, child: Text("Save")),
              )
            ],
          ),
        ),
      ),
    );
  }
}
