import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:moukalaf/admin/firstpage.dart';
import 'package:moukalaf/main.dart';
import 'package:moukalaf/user/setadress.dart';
import 'package:moukalaf/user/signup.dart';

addMember(value) async {
  var response = await http.post(Uri.http(ip, 'basic/web/kids/add-member'),
      body: {"userId": "$IdSignup", "memberName": "$value"});
  var jsonData = jsonDecode(response.body);

  print(jsonData);
}

setFamily() async {
  final queryParameters = {'id': "$IdSignup"};
  var response = await http
      .post(Uri.http(ip, 'basic/web/user/set-family', queryParameters), body: {
    "isMarried": $isMarriedTinyInt,
    "isPartnerWorking": $isWifeWorksTinyInt,
    "kidsNumber": "$KidsNumber",
  });
  var jsonData = jsonDecode(response.body);
  print(jsonData);
}

class famillyDeduction extends StatefulWidget {
  const famillyDeduction({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

List<TextEditingController> kidscontrollers =
    List.generate(KidsNumber, (index) => TextEditingController());
TextEditingController manController = TextEditingController();
TextEditingController womanController = TextEditingController();
bool isMarried = false;
String $isMarriedTinyInt = "0";
bool isWifeWorks = true;
String $isWifeWorksTinyInt = "0";
const List<int> kidsList = <int>[0, 1, 2, 3, 4, 5];

// ignore: non_constant_identifier_names

setTinyInt() {
  if (isMarried) {
    $isMarriedTinyInt = "1";
  } else {
    $isMarriedTinyInt = "0";
  }
  ;
  if (isWifeWorks) {
    $isWifeWorksTinyInt = "1";
  } else {
    $isWifeWorksTinyInt = "0";
  }
}

int KidsNumber = 1;

class _HomePageState extends State<famillyDeduction> {
  final _formKey = GlobalKey<FormState>();
  @override
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: // here the desired height
                AppBar(
              backgroundColor: Color(0xff3b63ff),
              leading: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                  setState(() {});
                },
                child: Icon(
                  Icons.arrow_back, //add color of your choice
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Container(
                  color: Colors.white,
                  child: Column(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        // ignore: prefer_const_constructors
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Text(
                                  " ان تحديد افراد العائلة يساعد على احتساب التنزيل العائلي\n",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: x,
                                  )),
                            ),
                          ],
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
                        SizedBox(
                          height: 10,
                        ),

                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Row(
                            children: [
                              Container(
                                width: 270,
                                child: TextFormField(
                                  textAlign: TextAlign.center,
                                  controller: manController,
                                  onSaved: (value) {
                                    addMember(value);
                                  },
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: x, // Blue color for text input
                                  ),
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    hintText: " اسم صاحب العمل", // Hint text
                                    hintStyle: TextStyle(
                                      fontSize: 20,
                                      color: Colors
                                          .grey, // Blue color for hint text
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      borderSide: BorderSide(
                                        color: Colors
                                            .grey, // Black border when not focused
                                        width: 2.0,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      borderSide: BorderSide(
                                        color: x, // Blue border when focused
                                        width: 2.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  Text(
                                    "هل انت متزوج(ة)؟",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  Transform.scale(
                                    scale: 1.5,
                                    child: Checkbox(
                                      value: isMarried,
                                      onChanged: (value) {
                                        setState(() {
                                          isMarried = value!;
                                          print(isMarried);

                                          isMarried
                                              ? isWifeWorks
                                              : isWifeWorks = true;
                                          isMarried
                                              ? KidsNumber
                                              : KidsNumber = 0;
                                          setTinyInt();
                                        });
                                      },
                                      activeColor: x,
                                      checkColor: Colors
                                          .white, // Color of the check mark inside the box
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Visibility(
                            visible: isMarried,
                            child: Row(
                              children: [
                                Container(
                                  width: 270,
                                  child: TextFormField(
                                    textAlign: TextAlign.center,
                                    controller: womanController,
                                    onSaved: (value) {
                                      addMember(value);
                                    },
                                    style: TextStyle(fontSize: 20, color: x),
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      hintText: "اسم زوج(ة)", // Hint text
                                      hintStyle: TextStyle(
                                        fontSize: 20,
                                        color: Colors
                                            .grey, // Grey color for hint text
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        borderSide: BorderSide(
                                          color: Colors
                                              .grey, // Grey border when not focused
                                          width: 2.0,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        borderSide: BorderSide(
                                          color: x,
                                          width: 2.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "هل الزوج(ة) تعمل ؟",
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                    Transform.scale(
                                      scale: 1.5,
                                      child: Checkbox(
                                        value: isWifeWorks,
                                        onChanged: (value) {
                                          setState(() {
                                            isWifeWorks = value!;
                                          });
                                        },
                                        activeColor: x,
                                        checkColor: Colors
                                            .white, // Color of the checkmark
                                      ),
                                    ),
                                    // ignore: prefer_const_constructors

                                    // ignore: prefer_const_constructors
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.fromLTRB(60, 0, 0, 0),
                          child: Visibility(
                            visible: isMarried,
                            child: Row(
                              children: [
                                DropdownButton<int>(
                                  value: KidsNumber,
                                  icon: const Icon(Icons.arrow_drop_down),
                                  elevation: 15,
                                  style:
                                      const TextStyle(color: x, fontSize: 20),
                                  underline: Container(
                                    height: 2,
                                    color: x,
                                  ),
                                  items: kidsList
                                      .map<DropdownMenuItem<int>>((int value) {
                                    return DropdownMenuItem<int>(
                                      value: value,
                                      child: Text(value.toString()),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      KidsNumber = value!;
                                      // Update the kidscontrollers list to match the new count
                                      kidscontrollers = List.generate(
                                          KidsNumber,
                                          (index) => TextEditingController());
                                      print(KidsNumber);
                                    });
                                  },
                                ),
                                const SizedBox(
                                  width: 50,
                                ),
                                // ignore: prefer_const_constructors
                                Text(
                                  "عدد الأولاد على عاتقكم؟",
                                  style: const TextStyle(fontSize: 25),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Visibility(
                          visible: isMarried,
                          child: SingleChildScrollView(
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.4,
                              width: 350,
                              child: ListView.separated(
                                shrinkWrap: false,
                                itemCount: KidsNumber,
                                itemBuilder: (BuildContext context, int index) {
                                  return TextFormField(
                                    textAlign: TextAlign
                                        .right, // Align text to the right
                                    controller: kidscontrollers[index],
                                    onSaved: (value) {
                                      addMember(value);
                                    },
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: x, // Set the text color to blue
                                    ),
                                    cursorColor:
                                        x, // Set the cursor color to blue
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      hintText:
                                          "اسم الأبناء", // Hint text in Arabic
                                      hintStyle: TextStyle(
                                        fontSize: 18,
                                        color: Colors
                                            .grey, // Grey color for hint text
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            20.0), // Rounded corners
                                        borderSide: BorderSide(
                                          color: Colors
                                              .grey, // Grey border when not focused
                                          width: 2.0,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            20.0), // Rounded corners
                                        borderSide: BorderSide(
                                          color: Colors
                                              .blue, // Blue border when focused
                                          width: 2.0,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) => SizedBox(
                                  height: 10,
                                ),
                              ),
                            ),
                          ),
                        ),

                        TextButton(
                          child: Text(
                            "التالي",
                            style: TextStyle(
                              fontSize: 25,
                              color: Color(0xff3b63ff),
                            ),
                          ),
                          style: TextButton.styleFrom(),
                          onPressed: () {
                            setState(() {
                              showProgress = true;
                            });
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Adress()));

                            setState(() {
                              _formKey.currentState?.save();
                              isMarried ? isWifeWorks : isWifeWorks = true;
                              isMarried ? KidsNumber : KidsNumber = 0;
                              setTinyInt();
                              setFamily();
                              showProgress = false;
                            });
                          },
                        ),
                      ]),
                ),
              ),
            )));
  }
}
