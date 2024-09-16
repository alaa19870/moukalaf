import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:moukalaf/admin/firstpage.dart';
import 'package:moukalaf/main.dart';
import 'package:moukalaf/user/signup.dart';

class Familly {
  late String memberName;
  Familly(this.memberName);
}

List<Familly> famillies = [];
Future<List<Familly>> getFamilly() async {
  famillies.clear();
  final queryParameters = {'id': '$IdSignup'};

  var response = await http
      .get(Uri.http(ip, 'basic/web/kids/get-familly', queryParameters));
  var jsonData = jsonDecode(response.body);
  for (var u in jsonData['data']) {
    Familly familly = Familly(
      u["memberName"],
    );
    famillies.add(familly);
  }

  print(jsonData);
  return famillies;
}

class FamillyMember extends StatelessWidget {
  const FamillyMember({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color(0xff3b63ff),
          title: Text(
            " افراد عائلة المستفيدين من تنزيل عائلي",
            style: TextStyle(fontSize: 20.0, color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Column(
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: 550, minHeight: 100.0),
                  child: FutureBuilder<List<Familly>>(
                      future: getFamilly(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<Familly> famillies =
                              snapshot.data as List<Familly>;

                          return ListView.separated(
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return SizedBox(height: 20);
                              },
                              scrollDirection: Axis.vertical,
                              padding: EdgeInsets.all(30),
                              itemCount: famillies.length,
                              itemBuilder: (Context, index) {
                                return Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: const Color(0xff3b63ff),
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: ListTile(
                                    leading: Icon(
                                      Icons.account_circle,
                                      color: const Color(0xff3b63ff),
                                    ),
                                    title: Text(
                                      famillies[index].memberName,
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: const Color(0xff3b63ff)),
                                    ),
                                  ),
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
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
