import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:moukalaf/admin/clientdetail.dart';
import 'package:moukalaf/admin/firstpage.dart';
import 'package:moukalaf/main.dart';
import 'pdfopen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

class Declaration {
  late String title;
  Declaration(this.title);
}

Future<void> uploadFile() async {
  var uri = Uri.parse("http://$ip/basic/web/uploads/addDeclaration.php");

  var request = http.MultipartRequest('POST', uri);

  // Use the file picker to select a PDF file
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['pdf'],
  );

  if (result != null) {
    // File picked successfully, continue with processing
    PlatformFile file = result.files.first;

    // Create an http.MultipartFile object using the selected file
    var pdf = await http.MultipartFile.fromPath(
      'pdf',
      file.path!,
      filename: file.name,
    );

    request.files.add(pdf);
    request.fields['userId'] = idFamilly;

    var response = await request.send();

    if (response.statusCode == 200) {
      Fluttertoast.showToast(
        msg: 'File uploaded successfully',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: x,
        textColor: Colors.white,
      );
    } else {
      Fluttertoast.showToast(
        msg: 'File upload failed',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  } else {
    // User canceled the file picker
    print('No file selected');
    Fluttertoast.showToast(
      msg: 'No file selected',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.grey,
      textColor: Colors.white,
    );
  }
}

Future<void> deleteFileFromServer(String fileToDelete) async {
  try {
    var response = await http.post(
      Uri.parse('http://$ip/basic/web/uploads/deleteDeclaration.php'),
      body: {'pdf': fileToDelete, 'userId': idFamilly},
    );

    if (response.statusCode == 200) {
      print('File deleted.');
      print(fileToDelete);
      print(idFamilly);

      // Additional actions after successful deletion
    } else {
      print('Failed to delete file. Status code: ${response.statusCode}');
      // Handle error case
    }
  } catch (error) {
    print('An error occurred while deleting file: $error');
    // Handle error case
  }
}

Future<List<Declaration>> fetchFiles() async {
  List<Declaration> declarationList = [];
  var url = Uri.parse('http://$ip/basic/web/uploads/list.php');
  try {
    var response = await http.post(
      url,
      body: {'userId': idFamilly},
    );

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      if (jsonData is List) {
        var data = jsonData as List<dynamic>;
        for (var item in data) {
          Declaration declaration = Declaration(
            item['pdf'].toString(),
          );
          declarationList.add(declaration);
        }
        print(jsonData);
        return declarationList;
      } else {
        print('Invalid response data format');
        throw Exception('Invalid response data format');
      }
    } else {
      print('Failed to fetch files. Status code: ${response.statusCode}');
      throw Exception('Failed to fetch files');
    }
  } catch (error) {
    print('Error: $error');
    throw Exception('An error occurred while fetching files');
  }
}

class FileListScreen extends StatefulWidget {
  const FileListScreen({Key? key}) : super(key: key);

  @override
  _FileListScreenState createState() => _FileListScreenState();
}

class _FileListScreenState extends State<FileListScreen> {
  late Future<List<Declaration>> _fetchFilesFuture;

  @override
  void initState() {
    super.initState();
    _fetchFilesFuture = fetchFiles();
  }

  Future<void> _refreshFiles() async {
    setState(() {
      _fetchFilesFuture = fetchFiles();
    });
  }

  Future<void> _showDeleteConfirmation(String title) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete File'),
          content: const Text('Are you sure you want to delete this file?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'No',
                style: TextStyle(color: x),
              ),
            ),
            TextButton(
              onPressed: () {
                deleteFileFromServer(title);
                Navigator.of(context).pop();
              },
              child: const Text(
                'Yes',
                style: TextStyle(color: x),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: x,
        title: Center(
            child: const Text(
          'تصاريح  المكلف ',
          style: TextStyle(color: Colors.white),
        )),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton.icon(
              onPressed: uploadFile,
              icon: Icon(
                Icons.cloud_upload,
                color: Colors.white,
              ),
              label: Text(
                'اضافة تصريح جديد',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(backgroundColor: x),
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _refreshFiles,
              child: FutureBuilder<List<Declaration>>(
                future: _fetchFilesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.blue, // Set the color to blue
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    final List<Declaration> declarationList = snapshot.data!;

                    return ListView.separated(
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(height: 20);
                      },
                      itemCount: declarationList.length,
                      itemBuilder: (context, index) {
                        final declaration = declarationList[index];

                        return Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DeclarationDetail(
                                    declarationFile: DeclarationFile(
                                      title: declaration.title,
                                    ),
                                  ),
                                ),
                              );
                            },
                            title: Center(
                              child: Text(
                                declaration.title,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    _showDeleteConfirmation(declaration.title);
                                  },
                                  icon: Icon(
                                    Icons.delete_forever,
                                    color: Color(0xff3b63ff),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    // Call your download function here
                                    downloadFile(declaration.title);
                                  },
                                  icon: Icon(
                                    Icons.download,
                                    color: Color(0xff3b63ff),
                                    // Replace this with the desired color for the download icon
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<String> downloadFile(String fileName) async {
    var url = 'http://$ip/basic/web/uploads/pdfs/$idFamilly/$fileName';
    File file;
    String filePath = '';

    try {
      // Request storage permission
      var status = await Permission.storage.request();
      if (!status.isGranted) {
        throw Exception('Storage permission not granted.');
      }

      // Continue with file download after getting the permission
      const downloadsFolderPath = '/storage/emulated/0/Download/';
      Directory dir = Directory(downloadsFolderPath);
      file = File('${dir.path}/$fileName');

      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        await file.writeAsBytes(response.bodyBytes);
        print('File downloaded successfully.');
      } else {
        throw Exception(
            'Failed to download file. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      filePath = 'Error: $e';
    }

    return filePath;
  }
}
