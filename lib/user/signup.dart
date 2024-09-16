import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:email_validator/email_validator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:moukalaf/admin/firstpage.dart';
import 'package:moukalaf/main.dart';
import 'package:moukalaf/user/setwork.dart';

var IdSignup;
bool checked = false;
TextEditingController username = TextEditingController();
TextEditingController password = TextEditingController();

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _UserState();
}

class _UserState extends State<Signup> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  var message = "";
  void validateEmail(String enteredEmail) {
    if (EmailValidator.validate(enteredEmail)) {
      setState(() {
        message = 'Your email seems nice!';
      });
    } else {
      setState(() {
        message = 'Please enter a valid email address!';
      });
    }
  }

  Future<void> checkUser() async {
    {
      try {
        var res = await http
            .post(Uri.parse("http://$ip/basic/web/user/check-user"), body: {
          "userName": username.text,
        });

        var response = json.decode(res.body);
        print(response);

        if (response['data'] == null) {
          setState(() {
            checked = true;
          });
        } else {
          Fluttertoast.showToast(
              msg: "choose another username",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 5,
              backgroundColor: Color(0xff3b63ff),
              fontSize: 16.0);
          setState(() {
            showProgress = false;
          });
        }
      } catch (e) {
        print(e);
      }
    }
  }

  Future<void> SaveAccount() async {
    setState(() {
      showProgress = false;
    });
    if (username.text != "" &&
        password.text != "" &&
        name.text != "" &&
        message == 'Your email seems nice!') {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const setWork()));
      setState(() {
        checked = false;
      });
      Fluttertoast.showToast(
          msg: "Now set your job",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 5,
          backgroundColor: const Color(0xff3b63ff),
          fontSize: 16.0);

      try {
        // ignore: unused_local_variable
        var res = await http
            .post(Uri.parse("http://$ip/basic/web/user/create-user"), body: {
          "userName": username.text,
          "password": password.text,
          "name": name.text,
          "email": email.text
        });
      } catch (e) {
        print(e);
      }
    } else {
      setState(() {
        showProgress = false;
      });
      Fluttertoast.showToast(
          msg: "Fill the blanks",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 5,
          backgroundColor: Color(0xff3b63ff),
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  void changeColor() {
    setState(() {
      // Change the button color here
      buttonColor = Colors.blue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: SingleChildScrollView(
                    child: Column(children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.15,
                    child: SizedBox(),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: Text(
                      "Moukalaf",
                      style: TextStyle(
                          fontSize: 50,
                          color: Color(0xff3b63ff),
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.05,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                          fontSize: 20,
                          color: Color(0xff3b63ff),
                          fontWeight: FontWeight.w100),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.01,
                    child: SizedBox(),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.03,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Enter Your Credentiels To Continue",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.01,
                    child: const SizedBox(),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.08,
                    width: 400,
                    child: TextFormField(
                      controller: username,
                      cursorColor: x, // Set the cursor color
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: x), // Default border color
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: x), // Enabled border color
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: x), // Focused border color
                        ),
                        filled:
                            true, // Use the filled property to add a background color
                        fillColor: Colors
                            .transparent, // Set the background color to transparent
                        labelText: "username",
                        labelStyle: TextStyle(
                          fontSize: 20,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.01,
                    child: const SizedBox(),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.08,
                    width: 400,
                    child: TextFormField(
                      controller: password,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field should be filled';
                        } else {
                          return null;
                        }
                      },
                      cursorColor: x, // Set the cursor color
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: x), // Default border color
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: x), // Enabled border color
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: x), // Focused border color
                        ),
                        filled:
                            true, // Use the filled property to add a background color
                        fillColor: Colors
                            .transparent, // Set the background color to transparent
                        labelText: "Password",
                        labelStyle: TextStyle(
                          fontSize: 20,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.01,
                    child: const SizedBox(),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.08,
                    width: 400,
                    child: TextFormField(
                      controller: name,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field should be filled';
                        } else {
                          return null;
                        }
                      },
                      cursorColor: x, // Set the cursor color
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: x), // Default border color
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: x), // Enabled border color
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: x), // Focused border color
                        ),
                        filled:
                            true, // Use the filled property to add a background color
                        fillColor: Colors
                            .transparent, // Set the background color to transparent
                        labelText: "Full Name",
                        labelStyle: TextStyle(
                          fontSize: 20,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.01,
                    child: const SizedBox(),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.08,
                    width: 400,
                    child: TextFormField(
                      onChanged: (enteredEmail) => validateEmail(enteredEmail),
                      controller: email,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field should be filled';
                        }
                        // Optionally, you can add email format validation here
                        return null;
                      },
                      cursorColor: x, // Set the cursor color
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: x), // Default border color
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: x), // Enabled border color
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: x), // Focused border color
                        ),
                        filled:
                            true, // Use the filled property to add a background color
                        fillColor: Colors
                            .transparent, // Set the background color to transparent
                        labelText: "Enter a valid email",
                        labelStyle: TextStyle(
                          fontSize: 20,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    message,
                    style: TextStyle(
                      color: x,
                    ),
                  ),
                  Container(
                    width: 300,
                    height: MediaQuery.of(context).size.height * 0.06,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: buttonColor,
                            foregroundColor: Colors.white),
                        onPressed: () async => {
                              setState(() {
                                showProgress = true;
                              }),
                              await checkUser(),
                              if (checked) {SaveAccount()}
                            },
                        child: Text(
                          "Sign Up",
                          style: TextStyle(fontSize: 20),
                        )),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.06,
                    child: Row(
                      children: <Widget>[
                        const Text(
                          'Already have an account?',
                          style: TextStyle(fontSize: 16),
                        ),
                        TextButton(
                            child: const Text(
                              'Login in',
                              style: TextStyle(
                                  color: x,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            ),
                            onPressed: () => {
                                  changeColor(),
                                  TextInput.finishAutofillContext(),
                                  Navigator.pop(context),
                                })
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                  ),
                  if (showProgress)
                    Container(
                      height: MediaQuery.of(context).size.height * 0.18,
                      child: SizedBox(
                        child: Center(
                            child: CircularProgressIndicator(
                          color: buttonColor,
                        )),
                        width: 100,
                      ),
                    ),
                ]))),
          ),
        ),
      ),
    ));
  }
}
