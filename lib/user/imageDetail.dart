import 'package:flutter/material.dart';
import 'package:moukalaf/admin/firstpage.dart';
import 'package:moukalaf/main.dart';

class Pictures {
  final String picture;

  Pictures({
    required this.picture,
  });
}

class ImageDetails extends StatelessWidget {
  final Pictures img;
  ImageDetails({required this.img});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: x,
        title: Text(
          "شهادة التسجيل",
          style: TextStyle(fontSize: 20.0, color: Colors.white),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        child: Image.network(
            errorBuilder: (context, error, stackTrace) =>
                Image.asset('asset/error.png'),
            'http://$ip/basic/web/uploads/images/${img.picture}'),
      ),
    );
  }
}
