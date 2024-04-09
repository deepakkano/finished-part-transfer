import 'package:flutter/material.dart';
import 'package:ftp/LoginPage.dart';
import 'package:ftp/dbHandler.dart';
import 'package:ftp/modelClass/dbModelAddInformation.dart';
import 'package:ftp/userQrCodeScanner.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowAllValue extends StatefulWidget {
  const ShowAllValue({super.key});
  @override
  State<ShowAllValue> createState() => _ShowAllValueState();
}
class _ShowAllValueState extends State<ShowAllValue> {
 var username;
  var userCompanyID;
  late Future<List<dbModelAddInformation>> listInfo;
  @override
  void initState() {
    
    fetchsingleuser();
    // loadListInfo();
    super.initState();
  }
  void fetchsingleuser() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    userCompanyID = sharedPref.getString('companyid');
    await dbHandler().fetchUserSingleData(userCompanyID).then((value) {
      setState(() {
        username = value != null ? value[0]['name'] ?? '' : '';
      });
    });
  }


Future<void> fetchData() async {
  final List<Map<String, dynamic>> companyData = await dbHandler().fetchDataForCompany(1);
  // Process the fetched data
  print(companyData);
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () async {
                  Get.to(UserQrCodeScanner());
                },
                icon: Icon(
                  Icons.qr_code,
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
      // body: Column(
      //   children: [
      //     FutureBuilder(future: listInfo,
      //      builder:(context,snaphsot){
      //       return ListView.builder(
      //         itemCount: 5,
      //         itemBuilder: (BuildContext context, int index) {
      //           return Card(
      //         child: ListTile(
      //           contentPadding: EdgeInsets.all(0),
      //           title: Text(snaphsot.data![index].barCodeNo.toString()),
      //         ),
      //         ) ;
      //         },
      //       );
      //      }
        
      // )],
      // )
    );
    
  }
}
