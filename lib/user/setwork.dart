import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:moukalaf/admin/firstpage.dart';
import 'package:moukalaf/main.dart';
import 'package:moukalaf/user/famillydeduction.dart';
import 'package:moukalaf/user/signup.dart';

var jobOfUser;
Future<void> loginin2() async {
  showProgress = true;
  try {
    var res =
        await http.post(Uri.parse("http://$ip/basic/web/user/log"), body: {
      "userName": username.text,
      "password": password.text,
    });

    var response = json.decode(res.body);
    print(response);

    if (response['data'] != null) {
      print(response['data']['id']);
      IdSignup = response['data']['id'];
    } else {}
  } catch (e) {
    print(e);
  }
}

class Work {
  late String id, workId, workName, workPercentage;

  Work(this.id, this.workId, this.workName, this.workPercentage);
}

List<Work> workList = [];
Future<List<Work>> getWorks() async {
  workList.clear();
  var response = await http.get(Uri.http(ip, 'basic/web/work/get-works'));
  var jsonData = jsonDecode(response.body);
  for (var u in jsonData['data']) {
    Work work = Work(
      u["id"].toString(),
      u["workId"].toString(),
      u["workName"],
      u["workPercentage"].toString(),
    );
    workList.add(work);
  }
  print(jsonData);
  return workList;
}

Future setJob($id) async {
  final queryParameters = {'id': $id};
  var response = await http
      .post(Uri.http(ip, 'basic/web/user/set-job', queryParameters), body: {
    "jobId": "$workId",
  });

  var jsonData = jsonDecode(response.body);
  print(jsonData);
}

Future getJob($id) async {
  final queryParameters = {'id': $id};
  var response =
      await http.post(Uri.http(ip, 'basic/web/user/get-user', queryParameters));
  var jsonData = jsonDecode(response.body);
  jobOfUser = jsonData['data'][0]['jobId'];
}

class setWork extends StatefulWidget {
  const setWork({super.key});

  // @override
  State<setWork> createState() => _MyWidgetState();
}

List filteredWorks = workList;
bool percentageVariable = false;
bool isvisible = true;
var percent;
var jobiD;
var workId;

TextEditingController _searchController = TextEditingController();

class _MyWidgetState extends State<setWork> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(),
        home: Scaffold(
            body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.height,
              color: x,
              child: Column(
                children: [
                  // ignore: prefer_const_constructors

                  Container(
                    height: MediaQuery.of(context).size.height * 0.05,
                    child: Text(
                      "الرجاء اختيار نشاط العمل ",
                      style: TextStyle(fontSize: 22, color: Colors.white),
                    ),
                  ),

                  const SizedBox(
                    height: 5,
                  ),
                  if (showProgress)
                    SizedBox(
                      child: Center(
                          child: CircularProgressIndicator(
                        color: buttonColor,
                      )),
                      width: 100,
                      height: 100,
                    ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (value) {
                        // Filter the items based on the entered text
                        setState(() {
                          filteredWorks = workList
                              .where((work) => work.workName
                                  .toLowerCase()
                                  .contains(value.toLowerCase()))
                              .toList();
                          isvisible = false;
                        });
                      },
                      style: TextStyle(
                          color: const Color(0xff3b63ff), // Set text color
                          backgroundColor:
                              Colors.transparent), // Set background color
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'ابحث عن نشاط أخر  مع رمز نشاط ونسبة الربح ',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        prefixIcon: IconButton(
                          icon: Icon(
                            Icons.clear,
                            color: x,
                          ),
                          onPressed: () {
                            setState(() {
                              _searchController.clear();
                              isvisible = true;
                            });
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const setWork()));
                            getWorks();
                            filteredWorks = workList;
                          },
                        ),
                      ),
                    ),
                  ),

                  Expanded(
                    child: FutureBuilder<List<Work>>(
                        future: getWorks(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.separated(
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return SizedBox(height: 10);
                                },
                                scrollDirection: Axis.vertical,
                                padding: EdgeInsets.all(10),
                                itemCount: filteredWorks.length,
                                itemBuilder: (Context, index) {
                                  return GestureDetector(
                                    onTap: () async {
                                      setState(() {
                                        workId = filteredWorks[index].id;
                                        print(workId);
                                        loginin2();
                                      });
                                      await setJob('$IdSignup');
                                      await setJob('$IdSignup');
                                      await getJob("$IdSignup");
                                      if (jobOfUser != null) {
                                        setState(() {
                                          showProgress = false;
                                        });
                                        print(jobOfUser);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    famillyDeduction()));
                                      } else {
                                        print("no job set");
                                        setState(() {
                                          showProgress = false;
                                        });
                                        Fluttertoast.showToast(
                                            msg: "Please tap again",
                                            toastLength: Toast.LENGTH_LONG,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 5,
                                            backgroundColor: Color(0xff3b63ff),
                                            fontSize: 16.0);
                                      }
                                    },
                                    child: Center(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        child: ListTile(
                                          leading: Text(
                                            filteredWorks[index].workId,
                                            style: TextStyle(
                                                fontSize: 14, color: x),
                                          ),
                                          title: Text(
                                            filteredWorks[index].workName,
                                            textDirection: TextDirection.rtl,
                                            style: TextStyle(
                                                fontSize: 14, color: x),
                                          ),
                                          trailing: Text(
                                            filteredWorks[index]
                                                    .workPercentage +
                                                "%",
                                            style: TextStyle(
                                                fontSize: 14, color: x),
                                          ),
                                        ),
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
                  )
                ],
              ),
            ),
          ),
        )));
  }
}
