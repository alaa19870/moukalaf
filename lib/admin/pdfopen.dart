import 'package:flutter/material.dart';
import 'package:moukalaf/admin/clientdetail.dart';
import 'package:moukalaf/admin/firstpage.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class DeclarationFile {
  final String title;

  DeclarationFile({
    required this.title,
  });
}

class DeclarationDetail extends StatelessWidget {
  final DeclarationFile declarationFile;
  DeclarationDetail({required this.declarationFile});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xff3b63ff),
          title: Text(
            "${declarationFile.title}",
            style: TextStyle(fontSize: 20.0, color: Colors.white),
          ),
        ),
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Color(0xff3b63ff),
                borderRadius: BorderRadius.circular(15)),
            child: SfPdfViewer.network(
                'http://$ip/basic/web/uploads/pdfs/${idFamilly}/${declarationFile.title}')),
      ),
    );
  }
}
