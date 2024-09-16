import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:moukalaf/admin/clientdetail.dart';
import 'dart:convert';

import 'package:moukalaf/admin/firstpage.dart';

class User {
  late String idUser,
      userName,
      password,
      name,
      telephone,
      email,
      personnelNumber,
      financialNumber,
      homeAdress,
      workAdress,
      job,
      eservicesUser,
      eservicesPass,
      image;
  User(
      this.idUser,
      this.userName,
      this.password,
      this.name,
      this.telephone,
      this.email,
      this.personnelNumber,
      this.financialNumber,
      this.homeAdress,
      this.workAdress,
      this.job,
      this.eservicesUser,
      this.eservicesPass,
      this.image);
}

List<User> userlist = [];

Future<List<User>> getUserByAdministrator(String id) async {
  userlist.clear();
  final queryParameters = {'id': id};
  var response = await http.get(
    Uri.http(
        '$ip', 'basic/web/user/get-client-with-job-and-image', queryParameters),
  );
  var jsonData = jsonDecode(response.body);
  for (var u in jsonData['data']) {
    User user = User(
      u["id"].toString(),
      u["userName"].toString(),
      u["password"].toString(),
      u["name"].toString(),
      u["telephone"].toString(),
      u["email"].toString(),
      u["personnelNumber"].toString(),
      u["financialNumber"].toString(),
      u["homeAdress"].toString(),
      u["workAdress"].toString(),
      u["workName"].toString(),
      u["eservicesUser"].toString(),
      u["eservicesPass"].toString(),
      u["image"].toString(),
    );
    userlist.add(user);
  }
  print(jsonData);
  return userlist;
}

class getClients extends StatelessWidget {
  const getClients({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Lora',
      ),
      home: SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50.0),
            child: AppBar(
              backgroundColor: const Color(0xff3b63ff),
              centerTitle: true,
              title: Text(
                'لائحة المكلفين',
                style: TextStyle(fontFamily: 'Lora', color: Colors.white),
              ),
            ),
          ),
          body: FutureBuilder<List<User>>(
            future: getUserByAdministrator(adminId
                .toString()), // Replace 'adminId' with the actual admin ID
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.blue,
                  ),
                );
              } else if (snapshot.hasError) {
                print(snapshot.error.toString());
                return Center(child: Text('Error'));
              } else if (snapshot.hasData) {
                return ListView.separated(
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider(
                      color: Colors.blue,
                      thickness: 2.0,
                    );
                  },
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.all(30),
                  itemCount: userlist.length,
                  itemBuilder: (context, index) {
                    return Container(
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 0.0), // Adjust the horizontal padding
                        leading: Icon(
                          Icons.arrow_back,
                          color: Colors.grey,
                        ),
                        title: Text(
                          userlist[index].name,
                          style: TextStyle(
                            fontSize: 20,
                            color: const Color(0xff3b63ff),
                          ),
                          textDirection: TextDirection
                              .rtl, // Set text direction to right-to-left
                        ),
                        subtitle: Text(
                          userlist[index].job,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                          textDirection: TextDirection
                              .rtl, // Set text direction to right-to-left
                        ),
                        trailing: CircleAvatar(
                          backgroundColor: Colors
                              .transparent, // Set background color to transparent

                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.grey,
                                // Set the desired border color
                                width: 1, // Adjust the border width as needed
                              ),
                            ),
                            child: Center(
                              child: Text(
                                (index + 1).toString(),
                                style: TextStyle(
                                  fontSize: 20,
                                  color: const Color(0xff3b63ff),
                                ),
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ItemDetails(
                                client: ItemClient(
                                    id: userlist[index].idUser,
                                    userName: userlist[index].userName,
                                    password: userlist[index].password,
                                    name: userlist[index].name,
                                    telephone: userlist[index].telephone,
                                    email: userlist[index].email,
                                    personnelNumber:
                                        userlist[index].personnelNumber,
                                    financialNumber:
                                        userlist[index].financialNumber,
                                    homeAdress: userlist[index].homeAdress,
                                    workAdress: userlist[index].workAdress,
                                    job: userlist[index].job,
                                    eservicesUser:
                                        userlist[index].eservicesUser,
                                    eservicesPass:
                                        userlist[index].eservicesPass,
                                    image: userlist[index].image),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}
