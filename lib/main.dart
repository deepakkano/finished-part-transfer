import 'package:flutter/material.dart';
import 'package:ftp/LoginPage.dart';
import 'package:ftp/addDataAdmin.dart';
import 'package:ftp/adminScanner.dart';
import 'package:ftp/dependencyInjection.dart';
import 'package:ftp/displayProductDetails.dart';
import 'package:ftp/editPageUser.dart';
// import 'package:ftp/navigationControler.dart';
import 'package:ftp/userQrCodeScanner.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
    DependencyInjection.init();

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme:
            AppBarTheme(backgroundColor: Colors.transparent, elevation: 0.0),
        useMaterial3: true,
      ),
      home: LoginPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() =>  _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


//      late SharedPreferences sharedPref;
//      late bool newuser;

//     void check_value_login() async {
//     sharedPref = await SharedPreferences.getInstance();
//     newuser = (sharedPref.getBool('login_flag') ?? true);
//       if (newuser == false) {
//       Get.off(() => LoginPage());
//     }
//     else{
// Get.to(UserQrCodeScanner());
//     }

//      @override
//      void initState() {
//        super.initState();
//        check_value_login();
//      }
//   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            ),
        body: Container());
  }
}
