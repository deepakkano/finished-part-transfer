// ignore_for_file: prefer_const_constructors, sort_child_properties_last

// import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ftp/addDataAdmin.dart';
import 'package:ftp/adminScanner.dart';
import 'package:ftp/barcodepage.dart';
import 'package:ftp/createUser.dart';
import 'package:ftp/dbHandler.dart';
import 'package:ftp/editPageUser.dart';
import 'package:ftp/modelClass/db_model.dart';
import 'package:ftp/userQrCodeScanner.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<String> valueitem = ["Production", "QA/QC", "Store","Admin"];

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController companyIdController = TextEditingController();
  TextEditingController userIdController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String? dropdownvalue = valueitem.first;

  late SharedPreferences sharedPref;
  late bool newuser;
  var flagvalue;
  var checkUserType;
  var arugcompany;
  final _formKey = GlobalKey<FormState>();
  bool passwordVisible = true;
  bool isLoginTrue = false;
  bool isLoadingTrue = false;

  void initState() {
    super.initState();
    check_value_login();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // backgroundColor: Colors.transparent,
          ),
      body: Container(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Container(
              // ignore: prefer_const_constructors
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 30,
                        ),
                        child: Text(
                          "Welcome",
                          style: TextStyle(
                              fontSize: 45, fontWeight: FontWeight.bold),
                        ),
                      )),

                  Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 35, bottom: 30),
                        child: Text(
                          "Please Enter Your Details.",
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      )),

                  Image.asset(
                    "assets/images/loginimage.png",
                    width: 200,
                    height: 200,
                  ),
                  // Align(
                  //   alignment: Alignment.center,
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(8.0),
                  //     child: Text("Login",
                  //         style: TextStyle(
                  //           fontSize: 35,
                  //           fontWeight: FontWeight.bold,
                  //         )),
                  //   ),
                  // ),

                  Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 35, bottom: 5),
                        child: Text(
                          "Role",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      )),
                  Padding(
                    padding: EdgeInsets.only(
                      right: 35,
                      left: 30,
                      bottom: 5,
                    ),
                    child: Container(
                        // color: Colors.red,
                        height: 65,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            width: 1.5,
                            color: Colors.black26,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: dropdownvalue,
                              // hint: "Select Your Role",
                              items: valueitem
                                  .map((e) => DropdownMenuItem<String>(
                                      value: e, child: Text(e)))
                                  .toList(),
                              onChanged: (v) {
                                setState(() {
                                  dropdownvalue = v;
                                });
                              },
                            ),
                          ),
                        )),
                  ),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 35, bottom: 5),
                        child: Text(
                          "Company ID",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      )),
                  Padding(
                    padding: EdgeInsets.only(right: 30, left: 30),
                    child: SizedBox(
                      height: 65,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        controller: companyIdController,
                        decoration: InputDecoration(
                          hintText: "Company ID",
                          // prefixIcon: Icon(Icons.man_2_outlined),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 35, bottom: 5),
                        child: Text(
                          "Username",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      )),
                  Padding(
                    padding: EdgeInsets.only(
                      //  bottom: 20, top: 20
                      right: 30, left: 30,
                    ),
                    child: SizedBox(
                      height: 65,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        controller: userIdController,
                        decoration: InputDecoration(
                          hintText: "UserName",
                          // prefixIcon: Icon(Icons.person_2),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 35, bottom: 5),
                        child: Text(
                          "Password",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      )),
                  Padding(
                    padding: EdgeInsets.only(right: 30, left: 30),
                    child: SizedBox(
                      height: 65,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        controller: passwordController,
                        obscureText: passwordVisible,
                        decoration: InputDecoration(
                          hintText: "Password",
                          // prefixIcon: Icon(Icons.password),
                          suffixIcon: IconButton(
                            icon: Icon(passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(
                                () {
                                  passwordVisible = !passwordVisible;
                                },
                              );
                            },
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      width: 300,
                      height: 50,
                      decoration: BoxDecoration(
                          // color: Color.fromARGB(255, 75, 57, 239),
                          borderRadius: BorderRadius.circular(20),
                          border: Border()),
                      child: ElevatedButton(
                          onPressed: () async {
                            // await dbHandler().fetchdata().then((value) {valu1 = value[0];},);
                            var companyid = companyIdController.text.trim();
                            var username = userIdController.text.trim();
                            var password = passwordController.text.trim();
                            checkUserType = dropdownvalue;
                            arugcompany = companyIdController.text.trim();

                            if (_formKey.currentState!.validate()) {
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

                                login();

                              });

                            }
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 75, 57, 239),
                            // shape: RoundedRectangleBorder()
                          )),
                    ),
                  ),

                  TextButton(
                      onPressed: () {
                        Get.to(createUser());
                      },
                      child: Text("Don't have an account yet? Sign Up")),
                  isLoginTrue
                      ? const Text(
                          "Username or passowrd is incorrect",
                          style: TextStyle(color: Colors.red),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  login() async {
    // Login Funtion
    var response = await dbHandler().getUserAuth(dbModel(
        companyId: companyIdController.text,
        username: userIdController.text,
        password: passwordController.text,
        role: dropdownvalue));

    if (response == true) {
      if (checkUserType == 'Admin') {
        // Checking UserType Here
        Get.to(AdminScanner());
      } else {
        sharedPref.setBool("login_flag", false);
        sharedPref.setString('companyid', companyIdController.text);
        sharedPref.setString("role", dropdownvalue.toString());
        Get.off(BarcodePage());
      }
    } else {
      setState(() {
        isLoginTrue = true;
      });
    }
  }

  void check_value_login() async {
    sharedPref = await SharedPreferences.getInstance();
    newuser = (sharedPref.getBool('login_flag') ?? true);
    if (newuser == false) {
      Get.off(() => BarcodePage());
    }
  }
}
