  import 'package:flutter/material.dart';
import 'package:ftp/dbHandler.dart';
import 'package:ftp/modelClass/db_model.dart';

class createUser extends StatefulWidget {
   const createUser({super.key});
 
   @override
   State<createUser> createState() => _createUserState();
 }
 
 class _createUserState extends State<createUser> {
  TextEditingController companyIdController = TextEditingController();
  TextEditingController userIdController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
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
            SizedBox(
              width: 150,
              child: ElevatedButton(
                  onPressed: () async {
                    await dbHandler()
                        .insertUserInfomation(dbModel(
                          companyId:companyIdController.text.trim(),
                          username:userIdController.text.trim(),
                          password:passwordController.text.trim(),
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