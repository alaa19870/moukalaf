import 'package:flutter/material.dart';
import 'package:moukalaf/admin/firstpage.dart';
import 'package:moukalaf/main.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class Titles {
  final String title;

  Titles({
    required this.title,
  });
}

class NewsDetails extends StatelessWidget {
  final Titles tit;
  NewsDetails({required this.tit});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: x,
          title: Text(
            "${tit.title}",
            style: TextStyle(fontSize: 20.0, color: Colors.white),
          ),
        ),
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: x, borderRadius: BorderRadius.circular(15)),
            child: SfPdfViewer.network(
                'http://$ip/basic/web/uploads/pdf/${tit.title}' + '.pdf')),
      ),
    );
  }
}
