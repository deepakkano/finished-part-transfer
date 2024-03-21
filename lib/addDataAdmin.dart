// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:ftp/adminScanner.dart';
import 'package:ftp/dbHandler.dart';
import 'package:ftp/modelClass/dbModelAddInformation.dart';
import 'package:get/get.dart';

class AddDataAdmin extends StatefulWidget {
  const AddDataAdmin({super.key});

  @override
  State<AddDataAdmin> createState() => _AddDataAdminState();
}

class _AddDataAdminState extends State<AddDataAdmin> {
  TextEditingController productName = TextEditingController();
  TextEditingController manufacturingPlant = TextEditingController();
  TextEditingController productDiminsion = TextEditingController();
  //   TextEditingController Description = TextEditingController();
  // TextEditingController Review = TextEditingController();

  var barCodeValue = Get.arguments[0]['codevalue'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Admin Name",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.remove_red_eye)),
          IconButton(
              onPressed: () {
                Get.to(AdminScanner());
              },
              icon: Icon(Icons.qr_code_scanner_outlined)),
          IconButton(onPressed: () {}, icon: Icon(Icons.logout)),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  readOnly: true,
                  controller: TextEditingController(text: barCodeValue),
                  // obscureText: true,s
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'BarCode no',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: productName,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Product Name',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: manufacturingPlant,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Manufacturing Plant',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: productDiminsion,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: ' Product Dimension',
                  ),
                ),
              ),
              SizedBox(
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlue,
                      //onPrimary: Colors.black,
                    ),
                    onPressed: () async {
                      await dbHandler()
                          .insertData(dbModelAddInformation(
                              barCodeNo: barCodeValue.trim(),
                              productName: productName.text.trim(),
                              manufacturingPlant:
                                  manufacturingPlant.text.trim(),
                              productDiminsion: productDiminsion.text.trim(),
                              Description: "null",
                              Review: "null"))
                          .then((value) => {print("Inserted")})
                          .onError((error, stackTrace) => {print('$error')});
                    },
                    child: Text("Save",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold)),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
