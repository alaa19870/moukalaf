import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:moukalaf/admin/firstpage.dart';
import 'package:moukalaf/main.dart';
import 'package:moukalaf/user/logout.dart';
import 'package:moukalaf/user/signup.dart';

class Administrator {
  late String idAdmin, name, location, adress, telephone, email;
  Administrator(this.idAdmin, this.name, this.location, this.adress,
      this.telephone, this.email);
}

class Smartstart extends StatefulWidget {
  @override
  _SmartstartState createState() => _SmartstartState();
}

class _SmartstartState extends State<Smartstart> {
  late List<Administrator> administrators;

  @override
  void initState() {
    super.initState();
    administrators = [];
    fetchAdministrators();
  }

  Future<void> fetchAdministrators() async {
    final queryParameters = {'location': 'Menyeh'};

    try {
      var response = await http.get(Uri.http(
          ip, 'basic/web/administrators/get-administrators', queryParameters));
      var jsonData = jsonDecode(response.body);
      List<Administrator> adminList = [];
      for (var u in jsonData['data']) {
        Administrator administrator = Administrator(
          u["id"].toString(),
          u["name"],
          u["location"],
          u["adress"],
          u["telephone"],
          u["email"],
        );
        adminList.add(administrator);
      }

      setState(() {
        administrators = adminList;
      });

      print(jsonData);
    } catch (error) {
      print('Error fetching administrators: $error');
    }
  }

  Future<void> setAdministrator(String id) async {
    final queryParameters = {'id': id};

    try {
      var response = await http.post(
        Uri.http(ip, 'basic/web/user/set-administrator', queryParameters),
        body: {
          "administrator": '6',
        },
      );
      var jsonData = jsonDecode(response.body);

      print(jsonData);
    } catch (error) {
      print('Error setting administrator: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xff3b63ff),
        title: Text(
          'Contact Us', // Replace with your desired title
          style: TextStyle(fontSize: 20.0, color: Colors.white),
        ),
      ),
      body: ListView.builder(
        itemCount: administrators.length,
        itemBuilder: (context, index) {
          final administrator = administrators[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 20.0), // Increased spacing
            child: ListTile(
              contentPadding: EdgeInsets.all(16.0),
              leading: Icon(
                Icons.business,
                size: 40, // Larger icon size
                color: x,
              ),
              title: Text(
                administrator.name,
                style: TextStyle(
                  fontSize: 24.0, // Larger font size
                  color: x,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.0), // Increased spacing
                  Text(
                    'Adress: ${administrator.adress}',
                    style: TextStyle(
                      fontSize: 18.0, // Larger font size
                      fontWeight: FontWeight.bold, // Bold text
                    ),
                  ),
                  SizedBox(height: 20.0), // Increased spacing
                  Text(
                    'Telephone: ${administrator.telephone}',
                    style: TextStyle(
                      fontSize: 18.0, // Larger font size
                    ),
                  ),
                  SizedBox(height: 20.0), // Increased spacing
                  Text(
                    'Email: ${administrator.email}',
                    style: TextStyle(
                      fontSize: 18.0, // Larger font size
                    ),
                  ),
                  SizedBox(height: 20.0), // Increased spacing
                  ElevatedButton(
                    onPressed: () {
                      setAdministrator('$IdSignup');
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Logout()),
                      );
                    },
                    child: Text(
                      'Send request',
                      style: TextStyle(color: x),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
