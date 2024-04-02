// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ftp/dbHandler.dart';
import 'package:ftp/displayProductDetails.dart';
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
   var ScanValue;
  var barCodeValue;
  TextEditingController? productNameController;
    TextEditingController? manufacturingController;
  TextEditingController? productDimensionController;
  TextEditingController? descriptionController;
  TextEditingController? remarkController;
  var updateId;


  @override
  void initState() {
    barCodeValue = Get.arguments['barcode'];
    getvalue();
    super.initState();
  }
 void getvalue() async {
    await dbHandler().fetchdataProduct(barCodeValue).then(
      (value) {
        setState(() {
          ScanValue = value;
          updateId=ScanValue != null ? ScanValue[0]['id'] ?? '' : '';
              productNameController = TextEditingController(
              text: ScanValue != null ? ScanValue[0]['productName'] ?? '' : ''); 
              manufacturingController = TextEditingController(
              text: ScanValue != null ? ScanValue[0]['manufacturingPlant'] ?? '' : '');
              productDimensionController = TextEditingController(
              text: ScanValue != null ? ScanValue[0]['productDiminsion'] ?? '' : '');
              descriptionController = TextEditingController(
              text: ScanValue != null ? ScanValue[0]['Description'] ?? '' : ' ');
              remarkController = TextEditingController(
              text: ScanValue != null ? ScanValue[0]['Review'] ?? '' : ' ');
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
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Description",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w100),
                  )),
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
              SizedBox(
                width: 200,
                child: ElevatedButton(onPressed: () async{

                  if (descriptionController != null && remarkController != null) {
    await dbHandler().updataproduct(
      updateId,
      descriptionController!.text,
      remarkController!.text,
    ).then((value) {
      // Handle the result if needed
    });
  }

Get.to(DisplayProductDetails(),arguments: {
'barocodevalue':barCodeValue
});



                }, child: Text("Save")),
              )
            ],
          ),
        ),
      ),
    );
  }
}
