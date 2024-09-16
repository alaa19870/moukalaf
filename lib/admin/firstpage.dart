import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:moukalaf/main.dart';
import 'package:moukalaf/admin/homeAdmin.dart';
import 'package:moukalaf/user/homepage.dart';
import 'package:moukalaf/user/income.dart';
import 'package:moukalaf/user/signup.dart';
import 'package:moukalaf/user/updateInfos.dart';
import 'package:shared_preferences/shared_preferences.dart';

var ip = "3.137.199.22";
bool showProgress = false;
bool isoffline = true;
var adminId;

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _UserState();
}

Widget errmsg(String text, bool show) {
  if (show == true) {
    return Container(
      padding: const EdgeInsets.all(10.00),
      margin: const EdgeInsets.only(bottom: 10.00),
      color: x,
      child: Row(children: [
        Container(
          margin: const EdgeInsets.only(right: 6.00),
          child: Icon(Icons.info, color: Colors.white),
        ),
        Text(text, style: const TextStyle(color: Colors.white)),
      ]),
    );
  } else {
    return Container();
  }
}

class _UserState extends State<FirstPage> {
  StreamSubscription? internetconnection;
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadCredentials();
  }

  Future<void> _loadCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? usern = prefs.getString('username');
    String? pass = prefs.getString('password');

    if (usern != null && pass != null) {
      username.text = usern;
      password.text = pass;
    }
  }

  Future<void> _saveCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username.text);
    await prefs.setString('password', password.text);
  }

  bool passwordVisible = true;
  bool next = true;

  Future<void> loginin() async {
    if (next == true) {
      try {
        var res =
            await http.post(Uri.parse("http://$ip/basic/web/user/log"), body: {
          "userName": username.text,
          "password": password.text,
        });

        var response = json.decode(res.body);
        print(response);

        if (response['data'] != null) {
          _saveCredentials();
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => MyHomePage()));
          IdSignup = response['data']['id'];
          nam = response['data']['name'];
          isPartnerWorking = response['data']['isPartnerWorking'];
          kidsNumber = response['data']['kidsNumber'];
        } else {
          setState(() {
            showProgress = false;
          });
          Fluttertoast.showToast(
              msg: "The account is incorrect",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 5,
              backgroundColor: x,
              fontSize: 16.0);
        }
      } catch (e) {
        print(e);
      }
    }
  }

  Future<void> loginInAdmin() async {
    try {
      var res = await http.post(
          Uri.parse("http://$ip/basic/web/administrators/log-admin"),
          body: {
            "userName": username.text,
            "password": password.text,
          });

      var response = json.decode(res.body);
      print(response);

      if (response['data'] != null) {
        _saveCredentials();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeAdmin()));
        adminId = response['data']['id'];
        setState(() {
          next = false;
          print(next);
        });
      }
    } catch (e) {
      print(e);
    }
  }

  log() async {
    await loginInAdmin();
    await loginin();
  }

  void changeColor() {
    setState(() {
      buttonColor = Colors.blue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Color.fromARGB(255, 66, 104, 255),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: Image.asset(
                      'asset/logo.png',
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.1,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                            child: Container(
                              child: TextFormField(
                                autofillHints: [AutofillHints.username],
                                controller: username,
                                cursorColor: x, // Set the cursor color to blue
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: x), // Default border color
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: x), // Enabled border color
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: x), // Focused border color
                                  ),
                                  filled:
                                      true, // Use the filled property to add a background color
                                  fillColor: Colors
                                      .transparent, // Set the background color to transparent
                                  prefixIcon: Icon(
                                    Icons.mail_lock_outlined,
                                    color: Colors
                                        .grey, // Set the icon color to gray
                                  ),
                                  labelText: "Username",
                                  labelStyle: TextStyle(
                                    fontSize: 20,
                                    color: Colors
                                        .grey, // Set the label color to gray
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.1,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                            child: Container(
                              child: TextFormField(
                                autofillHints: [AutofillHints.password],
                                controller: password,
                                obscureText: passwordVisible,
                                cursorColor: x, // Set the cursor color
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: x), // Default border color
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: x), // Enabled border color
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: x), // Focused border color
                                  ),
                                  filled:
                                      true, // Use the filled property to add a background color
                                  fillColor: Colors
                                      .transparent, // Set the background color to transparent
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: Colors
                                        .grey, // Set the icon color to gray
                                  ),
                                  labelText: "Password",
                                  labelStyle: TextStyle(
                                    fontSize: 20,
                                    color: Colors
                                        .grey, // Set the label color to gray
                                  ),

                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      passwordVisible
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Colors
                                          .grey, // Set the suffix icon color to gray
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        passwordVisible = !passwordVisible;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Container(
                          width: 300,
                          height: MediaQuery.of(context).size.height * 0.06,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: buttonColor,
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                showProgress = true;
                              });
                              log();
                              changeColor();
                            },
                            child: Text(
                              "Sign In",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.07,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const Text(
                                'Does not have an account?',
                                style: TextStyle(fontSize: 16),
                              ),
                              TextButton(
                                child: const Text(
                                  'Create one',
                                  style: TextStyle(
                                    color: x,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                onPressed: () {
                                  changeColor();
                                  TextInput.finishAutofillContext();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const Signup(),
                                    ),
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        if (showProgress)
                          SizedBox(
                            child: Center(
                              child: CircularProgressIndicator(
                                color: buttonColor,
                              ),
                            ),
                            width: 100,
                            height: MediaQuery.of(context).size.height * 0.07,
                          ),
                        if (!showProgress)
                          SizedBox(
                            child: Center(
                              child: SizedBox(),
                            ),
                            width: 100,
                            height: MediaQuery.of(context).size.height * 0.07,
                          ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.11,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  "Powered by Developix",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontStyle: FontStyle.normal,
                                    color: x,
                                  ),
                                ),
                                Icon(
                                  Icons.copyright,
                                  size: 14,
                                  color: x,
                                ),
                                Text(
                                  "2023",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontStyle: FontStyle.normal,
                                    color: x,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
