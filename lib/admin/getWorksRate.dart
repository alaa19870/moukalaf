import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:moukalaf/admin/firstpage.dart';

class Work {
  late String id, workId, workName, workPercentage;

  Work(this.id, this.workId, this.workName, this.workPercentage);
}

List<Work> WorkList = [];
Future<List<Work>> getWorks() async {
  WorkList.clear();
  var response = await http.get(Uri.http(ip, 'basic/web/work/get-works'));
  var jsonData = jsonDecode(response.body);
  for (var u in jsonData['data']) {
    Work work = Work(
      u["id"].toString(),
      u["workId"].toString(),
      u["workName"],
      u["workPercentage"].toString(),
    );
    WorkList.add(work);
  }
  print(jsonData);
  return WorkList;
}

class GetWorksRate extends StatefulWidget {
  const GetWorksRate({super.key});

  // @override
  State<GetWorksRate> createState() => _MyWidgetState();
}

List filteredWorks = WorkList;
bool percentageVariable = false;
bool isvisible = true;
var percent;
var jobiD;
var workId;

TextEditingController _searchController = TextEditingController();

class _MyWidgetState extends State<GetWorksRate> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(),
        home: SafeArea(
          child: Scaffold(
              body: Center(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.height,
              color: Color(0xff3b63ff),
              child: Center(
                child: Column(
                  children: [
                    // ignore: prefer_const_constructors

                    const SizedBox(
                      height: 10,
                    ),

                    Container(
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        controller: _searchController,
                        onChanged: (value) {
                          // Filter the items based on the entered text
                          setState(() {
                            filteredWorks = WorkList.where((work) => work
                                .workName
                                .toLowerCase()
                                .contains(value.toLowerCase())).toList();
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
                          hintText: 'ابحث عن نشاط مع رمز نشاط ونسبة الربح ',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          prefixIcon: IconButton(
                            icon: Icon(
                              Icons.clear,
                              color: const Color(0xff3b63ff),
                            ),
                            onPressed: () {
                              _searchController.clear();
                              isvisible = true;
                              getWorks();
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
                                                  fontSize: 12,
                                                  color:
                                                      const Color(0xff3b63ff)),
                                            ),
                                            title: Text(
                                              filteredWorks[index].workName,
                                              textDirection: TextDirection.rtl,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color:
                                                      const Color(0xff3b63ff)),
                                            ),
                                            trailing: Text(
                                              filteredWorks[index]
                                                      .workPercentage +
                                                  "%",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color:
                                                      const Color(0xff3b63ff)),
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
                              color: Colors.blue, // Set the color to blue
                            ));
                          }),
                    )
                  ],
                ),
              ),
            ),
          )),
        ));
  }
}
