import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moukalaf/admin/firstpage.dart';
import 'package:moukalaf/main.dart';
import 'package:moukalaf/user/signup.dart';

class Adress extends StatefulWidget {
  const Adress({super.key});

  @override
  State<Adress> createState() => _MyWidgetState();
}

TextEditingController WorkAdress = TextEditingController();
var Workadress;
TextEditingController homeAdress = TextEditingController();
var homeadress;

TextEditingController personalNumber = TextEditingController();
var personalnumber;
TextEditingController financeNumber = TextEditingController();
var financenumber;

TextEditingController telephoneNumber = TextEditingController();
var telephonenumber;

class _MyWidgetState extends State<Adress> {
  late XFile image;

  //we can upload image from camera or from gallery based on parameter
  Future sendImage(ImageSource media) async {
    final ImagePicker picker = ImagePicker();

    var img = await picker.pickImage(source: media);
    setState(() {
      image = img!;
    });

    var uri = "http://$ip/basic/web/uploads/create.php";

    var request = http.MultipartRequest('POST', Uri.parse(uri));

    // ignore: unnecessary_null_comparison
    if (image != null) {
      var pic = await http.MultipartFile.fromPath("image", image.path);

      request.files.add(pic);
      request.fields['idUser'] = '$IdSignup';
      var response = await request.send();

      if (response.statusCode == 200) {
        // Image upload successful
        Fluttertoast.showToast(
          msg: "image is uploaded",
          toastLength: Toast
              .LENGTH_LONG, // Duration for which the toast should be visible (SHORT: 2 seconds, LONG: 5 seconds)
          gravity: ToastGravity
              .BOTTOM, // Position of the toast on the screen (TOP, CENTER, or BOTTOM)
          backgroundColor: Colors.blue, // Background color of the toast
          textColor: Colors.white, // Text color of the toast
          fontSize: 16.0, // Font size of the toast message
        );
      } else {
        Fluttertoast.showToast(
          msg: "failled to upload image try again",
          toastLength: Toast
              .LENGTH_SHORT, // Duration for which the toast should be visible (SHORT: 2 seconds, LONG: 5 seconds)
          gravity: ToastGravity
              .BOTTOM, // Position of the toast on the screen (TOP, CENTER, or BOTTOM)
          backgroundColor: Colors.blue, // Background color of the toast
          textColor: Colors.white, // Text color of the toast
          fontSize: 16.0, // Font size of the toast message
        );
      }
    }
  }

  setAdress() async {
    var response =
        await http.post(Uri.http(ip, 'basic/web/user/set-adress'), body: {
      "id": "$IdSignup",
      "personnelNumber": "$personalnumber",
      "financialNumber": "$financenumber",
      "homeAdress": "$homeadress",
      "workAdress": "$Workadress",
      "telephone": "$telephonenumber",
    });
    var jsonData = jsonDecode(response.body);

    print(jsonData);
  }

  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text(
              'Please choose media to select',
              style: TextStyle(fontSize: 14),
            ),
            content: Container(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: [
                  ElevatedButton(
                    //if user click this button, user can upload image from gallery
                    onPressed: () {
                      sendImage(ImageSource.gallery);

                      Navigator.pop(context);
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.image,
                          color: x,
                        ),
                        Text(
                          'From Gallery',
                          style: TextStyle(color: x),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    //if user click this button. user can upload image from camera
                    onPressed: () {
                      sendImage(ImageSource.camera);

                      Navigator.pop(context);
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.camera,
                          color: x,
                        ),
                        Text(
                          'From Camera',
                          style: TextStyle(color: x),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              backgroundColor: x,
              leading: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                  setState(() {
                    // percentageVariable = false;
                  });
                },
                child: Icon(
                  Icons.arrow_back, //add color of your choice
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Text("ان تعبئة المعلومات يساعدك لاحقا في تعبئة التصريح  \n",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blue,
                      )),
                  if (showProgress)
                    SizedBox(
                      child: Center(
                          child: CircularProgressIndicator(
                        color: buttonColor,
                      )),
                      width: 100,
                      height: 100,
                    ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: TextFormField(
                        textAlign: TextAlign.center, // Align text to the right
                        controller: WorkAdress,
                        style: TextStyle(
                          fontSize: 18,
                          color: x, // Text color
                        ),
                        keyboardType: TextInputType.name, cursorColor: x,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(
                              color:
                                  Colors.grey, // Grey border when not focused
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
                          label: Center(child: Text('  عنوان العمل')),
                          labelStyle: TextStyle(
                            fontSize: 18,
                            letterSpacing: 1,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey, // Label color
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      )),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: TextFormField(
                        textAlign: TextAlign.center, // Align text to the right
                        controller: homeAdress,
                        style: TextStyle(
                          fontSize: 18,
                          color: x, // Text color
                        ),
                        keyboardType: TextInputType.name, cursorColor: x,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(
                              color:
                                  Colors.grey, // Grey border when not focused
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
                          label: Center(child: Text('  عنوان السكن')),
                          labelStyle: TextStyle(
                            fontSize: 18,
                            letterSpacing: 1,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey, // Label color
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      controller: personalNumber,
                      style: TextStyle(
                        fontSize: 20,
                        color: x,
                      ),
                      keyboardType: TextInputType.number,
                      cursorColor: x,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(
                            color: Colors.grey, // Grey border when not focused
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
                        label: const Center(child: Text('  الرقم الشخصي ')),
                        labelStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                            letterSpacing: 1,
                            fontWeight: FontWeight.bold),
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      controller: financeNumber,
                      style: TextStyle(
                        fontSize: 18,
                        color: x,
                      ),
                      keyboardType: TextInputType.number,
                      cursorColor: x,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(
                            color: Colors.grey, // Grey border when not focused
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
                        label: const Center(child: Text('  الرقم المالي ')),
                        labelStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                            letterSpacing: 1,
                            fontWeight: FontWeight.bold),
                        fillColor: x,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      controller: telephoneNumber,
                      style: TextStyle(
                        fontSize: 18,
                        color: x,
                      ),
                      keyboardType: TextInputType.number,
                      cursorColor: x,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(
                            color: Colors.grey, // Grey border when not focused
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
                        label: const Center(child: Text('  رقم الهاتف  ')),
                        labelStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                            letterSpacing: 1,
                            fontWeight: FontWeight.bold),
                        fillColor: x,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 60,
                    width: 200,
                    child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color>(
                            Colors.blue,
                          ),
                        ),
                        onPressed: () => myAlert(),
                        child: Text(
                          "تحميل شهادة التسجيل",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextButton(
                    child: Text(
                      "التالي",
                      style: TextStyle(
                        fontSize: 30,
                        color: Color(0xff3b63ff),
                      ),
                    ),
                    style: TextButton.styleFrom(),
                    onPressed: () {
                      setState(() {
                        showProgress = true;
                        Workadress = WorkAdress.text;
                        homeadress = homeAdress.text;
                        financenumber = financeNumber.text;
                        personalnumber = personalNumber.text;
                        telephonenumber = telephoneNumber.text;
                        setAdress();
                      });
                      Fluttertoast.showToast(
                        msg: "YOUR ACCOUNT IS CREATED NOW LOGIN",
                        toastLength: Toast
                            .LENGTH_SHORT, // Duration for which the toast will be displayed
                        gravity: ToastGravity
                            .BOTTOM, // Position where the toast will be shown on the screen
                        timeInSecForIosWeb:
                            3, // Time for iOS-specific web platforms
                        backgroundColor: Color(0xff3b63ff),
                        textColor: Colors.white, // Text color of the toast
                        fontSize: 12.0, // Font size of the toast message
                      );
                      Future.delayed(const Duration(seconds: 3), () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MyApp()),
                        );
                        setState(() {
                          showProgress = false;
                        });
                      });
                    },
                  ),
                ],
              ),
            )));
  }
}
