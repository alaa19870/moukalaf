import 'package:flutter/material.dart';
import 'package:moukalaf/main.dart';

class Logout extends StatelessWidget {
  const Logout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: null,
      appBar: AppBar(
        backgroundColor: x,
        title: Center(
          child: Text(
            "Contact Us",
            style: TextStyle(fontSize: 20.0, color: Colors.white),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
            ),
            Center(
              child: Container(
                child: Text(
                  'لقد تم استلام المعلومات سيتم التواصل معكم قريبا ',
                  style:
                      TextStyle(fontSize: 18, color: const Color(0xff3b63ff)),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
