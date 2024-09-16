import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:moukalaf/admin/firstpage.dart';
import 'package:moukalaf/main.dart';
import 'package:moukalaf/user/signup.dart';

var nam;
var tele;
var em;
var perNumber;
var finNumber;
var hoadress;
var woadress;
var eserviceuser;
var eservicepass;

class SemiCircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final centerX = size.width / 2;
    final centerY = size.height / 2.2;
    final radius = size.width / 1.5;

    path.moveTo(centerX + radius, centerY);
    path.arcToPoint(Offset(centerX - radius, centerY),
        radius: Radius.circular(radius), clockwise: true);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class User {
  late String idUser,
      userName,
      name,
      telephone,
      email,
      personnelNumber,
      financialNumber,
      homeAdress,
      workAdress,
      job,
      image,
      workName,
      workId,
      workPercentage,
      eservicesUser,
      eservicesPass;
  User(
      this.idUser,
      this.userName,
      this.name,
      this.telephone,
      this.email,
      this.personnelNumber,
      this.financialNumber,
      this.homeAdress,
      this.workAdress,
      this.job,
      this.image,
      this.workName,
      this.workId,
      this.workPercentage,
      this.eservicesUser,
      this.eservicesPass);
}

List<User> userlist = [];
Future<List<User>> getUser($id) async {
  userlist.clear();
  final queryParameters = {'id': $id.toString()};
  var response = await http
      .get(Uri.http(ip, 'basic/web/user/get-client-status', queryParameters));
  var jsonData = jsonDecode(response.body);

  for (var u in jsonData['data']) {
    User user = User(
      u["idUser"].toString(),
      u["userName"].toString(),
      u["name"].toString(),
      u["telephone"].toString(),
      u["email"].toString(),
      u["personnelNumber"].toString(),
      u["financialNumber"].toString(),
      u["homeAdress"].toString(),
      u["workAdress"].toString(),
      u["jobName"].toString(),
      u["image"].toString(),
      u["workName"].toString(),
      u["workId"].toString(),
      u["workPercentage"].toString(),
      u["eservicesUser"].toString(),
      u["eservicesPass"].toString(),
    );
    userlist.add(user);
  }
  print(jsonData);

  return userlist;
}

updateInfos() async {
  // final queryParameters = {'id': $id.toString()};
  var response =
      await http.post(Uri.http(ip, 'basic/web/user/update-infos'), body: {
    "id": "$IdSignup",
    "name": "$nam",
    "telephone": "$tele",
    "email": "$em",
    "personnelNumber": "$perNumber",
    "financialNumber": "$finNumber",
    "homeAdress": "$hoadress",
    "workAdress": "$woadress",
    "eservicesUser": "$eserviceuser",
    "eservicesPass": "$eservicepass"
  });
  var jsonData = jsonDecode(response.body);

  print(jsonData);
}

DeleteUser($id) async {
  final queryParameters = {'id': $id.toString()};
  var response = await http
      .post(Uri.http(ip, 'basic/web/user/delete-user', queryParameters));
  var jsonData = jsonDecode(response.body);

  print(jsonData);
}

class UpdateInfos extends StatefulWidget {
  const UpdateInfos({super.key});

  @override
  State<UpdateInfos> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<UpdateInfos> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController name = TextEditingController();
  final TextEditingController telephone = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController personnelNumber = TextEditingController();
  final TextEditingController financialNumber = TextEditingController();
  final TextEditingController homeAdress = TextEditingController();
  final TextEditingController workAdress = TextEditingController();

  @override
  Widget build(BuildContext context) {
    getUser(65);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Lora',
        ),
        home: Scaffold(
          body: SingleChildScrollView(
            child: Column(children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
                width: 400,
                child: Stack(
                  children: [
                    Positioned(
                      top: -320,
                      child: ClipPath(
                          clipper: SemiCircleClipper(),
                          child: Container(
                            width: 400,
                            height: 500,
                            color: x,
                          )),
                    ),
                    Positioned(
                      left: 150,
                      top: 110,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 50.0,
                        child: Icon(
                          Icons.person,
                          size: 60,
                          color: x,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Form(
                key: _formKey,
                child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.7,
                      minHeight: MediaQuery.of(context).size.height * 0.7,
                    ),
                    child: FutureBuilder<List<User>>(
                        future: getUser(IdSignup),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.separated(
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return SizedBox(height: 0);
                                },
                                scrollDirection: Axis.vertical,
                                padding: EdgeInsets.all(0),
                                itemCount: 1,
                                itemBuilder: (Context, index) {
                                  nam = userlist[index].name;
                                  tele = userlist[index].telephone;
                                  em = userlist[index].email;
                                  perNumber = userlist[index].personnelNumber;
                                  finNumber = userlist[index].financialNumber;
                                  hoadress = userlist[index].homeAdress;
                                  woadress = userlist[index].workAdress;

                                  return Column(
                                    children: [
                                      ListTile(
                                        leading: Icon(
                                          Icons.person,
                                          color: x,
                                        ),
                                        trailing: Text(
                                          'الاسم',
                                          style:
                                              TextStyle(color: x, fontSize: 16),
                                        ),
                                        title: TextFormField(
                                          initialValue: userlist[index].name,
                                          onChanged: (value) {
                                            // if (name.text.isNotEmpty) {
                                            nam = value;
                                            // name.text;
                                            // }
                                          },
                                          // controller: name,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            // hintText: userlist[index].name,
                                            hintStyle: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          style:
                                              TextStyle(fontSize: 16, color: x),
                                        ),
                                      ),
                                      Divider(
                                        color: Colors.grey,
                                        thickness: 1,
                                        height: 1,
                                      ),
                                      ListTile(
                                        leading: Icon(
                                          Icons.call,
                                          color: x,
                                        ),
                                        trailing: Text(
                                          'رقم الهاتف',
                                          style:
                                              TextStyle(color: x, fontSize: 16),
                                        ),
                                        title: TextFormField(
                                          initialValue:
                                              userlist[index].telephone,
                                          onChanged: (value) {
                                            // if (telephone.text.isNotEmpty) {
                                            tele = value;
                                            // }
                                          },
                                          // controller: telephone,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            // hintText: userlist[index].telephone,
                                            hintStyle: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          style:
                                              TextStyle(fontSize: 16, color: x),
                                        ),
                                      ),
                                      Divider(
                                        color: Colors.grey,
                                        thickness: 1,
                                        height: 1,
                                      ),
                                      ListTile(
                                        leading: Icon(
                                          Icons.email,
                                          color: x,
                                        ),
                                        trailing: Text(
                                          'البريد الالكتروني',
                                          style:
                                              TextStyle(color: x, fontSize: 16),
                                        ),
                                        title: TextFormField(
                                          initialValue: userlist[index].email,
                                          onChanged: (value) {
                                            // if (email.text.isNotEmpty) {
                                            em = value;
                                            // }
                                          },
                                          // controller: email,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            // hintText: userlist[index].email,
                                            hintStyle: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          style:
                                              TextStyle(fontSize: 16, color: x),
                                        ),
                                      ),
                                      Divider(
                                        color: Colors.grey,
                                        thickness: 1,
                                        height: 1,
                                      ),
                                      ListTile(
                                        leading: Icon(
                                          Icons.person_2,
                                          color: x,
                                        ),
                                        trailing: Text(
                                          'الرقم الشخصي',
                                          style:
                                              TextStyle(color: x, fontSize: 16),
                                        ),
                                        title: TextFormField(
                                          initialValue:
                                              userlist[index].personnelNumber,
                                          onChanged: (value) {
                                            // if (personnelNumber
                                            // .text.isNotEmpty) {
                                            perNumber = value;
                                            // }
                                          },
                                          // controller: personnelNumber,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            // hintText:
                                            //     userlist[index].personnelNumber,
                                            hintStyle: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          style:
                                              TextStyle(fontSize: 16, color: x),
                                        ),
                                      ),
                                      Divider(
                                        color: Colors.grey,
                                        thickness: 1,
                                        height: 1,
                                      ),
                                      ListTile(
                                        leading: Icon(
                                          Icons.work,
                                          color: x,
                                        ),
                                        trailing: Text(
                                          'الرقم المالي',
                                          style:
                                              TextStyle(color: x, fontSize: 16),
                                        ),
                                        title: TextFormField(
                                          initialValue:
                                              userlist[index].financialNumber,
                                          onChanged: (value) {
                                            // if (financialNumber
                                            //     .text.isNotEmpty) {
                                            finNumber = value;
                                            // }
                                          },
                                          // controller: financialNumber,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            // hintText:
                                            //     userlist[index].financialNumber,
                                            hintStyle: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          style:
                                              TextStyle(fontSize: 16, color: x),
                                        ),
                                      ),
                                      Divider(
                                        color: Colors.grey,
                                        thickness: 1,
                                        height: 1,
                                      ),
                                      ListTile(
                                        leading: Icon(
                                          Icons.home,
                                          color: x,
                                        ),
                                        trailing: Text(
                                          'مكان السكن',
                                          style:
                                              TextStyle(color: x, fontSize: 16),
                                        ),
                                        title: TextFormField(
                                          initialValue:
                                              userlist[index].homeAdress,
                                          onChanged: (value) {
                                            // if (homeAdress.text.isNotEmpty) {
                                            hoadress = value;
                                            // }
                                          },
                                          // controller: homeAdress,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText:
                                                userlist[index].homeAdress,
                                            hintStyle: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          style:
                                              TextStyle(fontSize: 16, color: x),
                                        ),
                                      ),
                                      Divider(
                                        color: Colors.grey,
                                        thickness: 1,
                                        height: 1,
                                      ),
                                      ListTile(
                                        leading: Icon(
                                          Icons.desk,
                                          color: x,
                                        ),
                                        trailing: Text(
                                          'مكان العمل',
                                          style:
                                              TextStyle(color: x, fontSize: 16),
                                        ),
                                        title: TextFormField(
                                          initialValue:
                                              userlist[index].workAdress,
                                          onChanged: (value) {
                                            // if (workAdress.text.isNotEmpty) {
                                            woadress = value;
                                            // }
                                          },
                                          // controller: workAdress,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText:
                                                userlist[index].workAdress,
                                            hintStyle: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          style:
                                              TextStyle(fontSize: 16, color: x),
                                        ),
                                      ),
                                      Divider(
                                        color: Colors.grey,
                                        thickness: 1,
                                        height: 1,
                                      ),
                                      ListTile(
                                        leading: Icon(
                                          Icons.support_agent,
                                          color: x,
                                        ),
                                        trailing: Text(
                                          'الحساب الالكتروني ',
                                          style:
                                              TextStyle(color: x, fontSize: 16),
                                        ),
                                        title: TextFormField(
                                          initialValue:
                                              userlist[index].eservicesUser,
                                          onChanged: (value) {
                                            // if (workAdress.text.isNotEmpty) {
                                            eserviceuser = value;
                                            // }
                                          },
                                          // controller: workAdress,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText:
                                                userlist[index].eservicesUser,
                                            hintStyle: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          style:
                                              TextStyle(fontSize: 16, color: x),
                                        ),
                                      ),
                                      Divider(
                                        color: Colors.grey,
                                        thickness: 1,
                                        height: 1,
                                      ),
                                      ListTile(
                                        leading: Icon(
                                          Icons.password_outlined,
                                          color: x,
                                        ),
                                        trailing: Text(
                                          'رمز الحساب  ',
                                          style:
                                              TextStyle(color: x, fontSize: 16),
                                        ),
                                        title: TextFormField(
                                          initialValue:
                                              userlist[index].eservicesPass,
                                          onChanged: (value) {
                                            // if (workAdress.text.isNotEmpty) {
                                            eservicepass = value;
                                            // }
                                          },
                                          // controller: workAdress,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText:
                                                userlist[index].eservicesPass,
                                            hintStyle: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          style:
                                              TextStyle(fontSize: 16, color: x),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Please Fill all the cases above',
                                        style:
                                            TextStyle(color: x, fontSize: 14),
                                      ),
                                      ElevatedButton(
                                          onPressed: () {
                                            _formKey.currentState?.save();
                                            updateInfos();
                                          },
                                          child: Text(
                                            "Update Information",
                                            style: TextStyle(fontSize: 20),
                                          )),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.03,
                                      ),
                                      Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              'I do not need my account',
                                              style: TextStyle(
                                                color: x,
                                                fontSize: 14,
                                              ),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      title: Text(
                                                          "Confirm Delete"),
                                                      content: Text(
                                                          "Are you sure you want to delete your account? This action cannot be undone."),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context); // Close the dialog
                                                          },
                                                          child: Text(
                                                            "Cancel",
                                                            style: TextStyle(
                                                                color: x),
                                                          ),
                                                        ),
                                                        TextButton(
                                                          onPressed: () {
                                                            DeleteUser(
                                                                IdSignup);
                                                            print(IdSignup);
                                                            Navigator
                                                                .pushReplacement(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        const FirstPage(),
                                                              ),
                                                            );
                                                          },
                                                          style: TextButton
                                                              .styleFrom(),
                                                          child: Text(
                                                            "Delete",
                                                            style: TextStyle(
                                                              color:
                                                                  x, // Set text color to your desired color
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors
                                                    .white, // Change the button color as needed
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "Delete account",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: x,
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  );
                                });
                          }
                          if (snapshot.hasError) {
                            print(snapshot.error.toString());
                            return Text('error');
                          }
                          return Center(
                              child: CircularProgressIndicator(
                            color: buttonColor,
                          ));
                        })),
              ),
            ]),
          ),
        ));
  }
}
