// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ftp/addDataAdmin.dart';
import 'package:ftp/adminScanner.dart';
import 'package:ftp/createUser.dart';
import 'package:ftp/dbHandler.dart';
import 'package:ftp/modelClass/db_model.dart';
import 'package:ftp/userQrCodeScanner.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController companyIdController = TextEditingController();
  TextEditingController userIdController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var checkUserType;
  final _formKey = GlobalKey<FormState>();
  bool passwordVisible = true;
  bool isLoginTrue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.transparent,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            // ignore: prefer_const_constructors
            child: Column(
              children: [
                Image.asset(
                  "assets/images/loginimage.png",
                  width: 200,
                  height: 200,
                ),
                Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 35),
                      child: Text("Login",
                          style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          )),
                    )),
                Padding(
                  padding: EdgeInsets.only(right: 30, left: 30),
                  child: SizedBox(
                    height: 60,
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
                        prefixIcon: Icon(Icons.man_2_outlined),
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
                Padding(
                  padding:
                      EdgeInsets.only(right: 30, left: 30, bottom: 20, top: 20),
                  child: SizedBox(
                                        height: 60,

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
                        prefixIcon: Icon(Icons.person_2),
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
                Padding(
                  padding: EdgeInsets.only(right: 30, left: 30),
                  child: SizedBox(
                  height: 60,

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
                        prefixIcon: Icon(Icons.password),
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
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
             
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: SizedBox(
                    width: 300,
                    child: ElevatedButton(
                        onPressed: () async {
                          // await dbHandler().fetchdata().then((value) {valu1 = value[0];},);
                          var companyid = companyIdController.text.trim();
                          var username = userIdController.text.trim();
                          var password = passwordController.text.trim();
                          checkUserType = companyIdController.text.trim();
                          
                          if (_formKey.currentState!.validate()) {
                            login();
                    
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Processing Data')),
                            );
                          }
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 75, 57, 239),
                            shape: RoundedRectangleBorder())),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Divider(
                    color: Colors.black,
                    height: 50,
                    thickness:2,
                  ),
                ),
                
              TextButton(onPressed: (){   Get.to(createUser());}, child:  
                   
                    Text("CreateUser")),
                isLoginTrue
                    ? const Text(
                        "Username or passowrd is incorrect",
                        style: TextStyle(color: Colors.red),
                      )
                    : const SizedBox(),                Text("Term & Conditions"),

              ],
            ),
          ),
        ),
      ),
    );
  }

  login() async { // Login Funtion
    var response = await dbHandler().getUserAuth(dbModel(
        companyId: companyIdController.text,
        username: userIdController.text,
        password: passwordController.text));
    if (response == true) {
      if (checkUserType == 'x1234') { // Checking UserType Here
        Get.to(AdminScanner());
      } else {
        Get.to(UserQrCodeScanner());
      }
    } else {
      setState(() {
        isLoginTrue = true;
      });
    }
  }
}
