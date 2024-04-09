  import 'package:flutter/material.dart';
import 'package:ftp/dbHandler.dart';
import 'package:ftp/modelClass/db_model.dart';
List<String> valueitem = ["Production", "QA/QC", "Store","Admin"];

class createUser extends StatefulWidget {
   const createUser({super.key});
 
   @override
   State<createUser> createState() => _createUserState();
 }
 
 class _createUserState extends State<createUser> {
  TextEditingController nameIdController = TextEditingController();
    TextEditingController companyIdController = TextEditingController();

  TextEditingController userIdController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
    TextEditingController emailIdController = TextEditingController();
    String? dropdownvalue = valueitem.first;

  var valu1;
   @override
   Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        
       
      ),
      body:  Column(
          children: [
              Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: nameIdController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Company id"),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: companyIdController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Company id"),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: userIdController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Userid"),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Password"),
                ),
              ),
            ),
              Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: emailIdController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Company id"),
                ),
              ),
            ),Align(
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
            SizedBox(
              width: 150,
              child: ElevatedButton(
                  onPressed: () async {
                    await dbHandler()
                        .insertUserInfomation(dbModel(
                          name: nameIdController.text.trim(),
                          companyId:companyIdController.text.trim(),
                          username:userIdController.text.trim(),
                          password:passwordController.text.trim(),
                          email: emailIdController.text.trim(),
                          role: dropdownvalue,

                        ))
                        .then((value) => {print("Inserted")})
                        .onError((error, stackTrace) => {print('$error')});
                  },
                  child: Text("Login")),
            ),
            ElevatedButton(
                onPressed: () async {
                  await dbHandler().fetchUserData().then(
                    (value) {
for (var candidate in value) {
print(candidate);}
},
                  );
                },
                child: Text("REad")),
            Text('this is a  value :-$valu1'),
          ],
        ));
   }
 }