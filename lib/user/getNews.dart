import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:moukalaf/admin/firstpage.dart';
import 'package:moukalaf/main.dart';
import 'package:moukalaf/user/newdetail.dart';

class News {
  late String title;

  News(this.title);
}

List<News> newsList = [];

Future<List<News>> getNews() async {
  newsList.clear();

  var response = await http.get(Uri.http(ip, 'basic/web/news/get-news'));
  var jsonData = jsonDecode(response.body);
  for (var u in jsonData['data']) {
    News news = News(u["title"]);
    newsList.add(news);
  }

  print(jsonData);
  return newsList;
}

class getAllNews extends StatefulWidget {
  const getAllNews({Key? key}) : super(key: key);

  @override
  _getAllNewsState createState() => _getAllNewsState();
}

class _getAllNewsState extends State<getAllNews> {
  late List<News> filteredNewsList;
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    filteredNewsList = [];
    searchController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Center(
            child: Text(
              'قرارات مالية وضريبية',
              style: TextStyle(
                fontSize: 20,
                color: const Color(0xff3b63ff),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    textAlign: TextAlign.center,
                    controller: searchController,
                    cursorColor: x, // Set cursor color to blue

                    style: TextStyle(color: const Color(0xff3b63ff)),

                    decoration: InputDecoration(
                      labelText: 'بحث', // Translation for 'Search' in Arabic
                      labelStyle: TextStyle(color: x),
                      prefixIcon: Icon(Icons.search,
                          color: x), // Set icon color to blue
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: x),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: x,
                          width: 2.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: x,
                          width: 1.0,
                        ),
                      ),
                      hintStyle: TextStyle(),
                      alignLabelWithHint:
                          true, // Aligns the label text with the hint text
                      contentPadding: EdgeInsetsDirectional.fromSTEB(
                          12, 8, 0, 8), // Adjust padding as needed
                    ),
                    textDirection: TextDirection
                        .rtl, // Set the text direction to right-to-left
                    onChanged: (value) {
                      filterNews(value);
                    },
                  ),
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: 550, minHeight: 100.0),
                  child: FutureBuilder<List<News>>(
                    future: getNews(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                            child: CircularProgressIndicator(
                          color: buttonColor,
                        ));
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(child: Text('No news found.'));
                      } else {
                        List<News> listNews = filteredNewsList.isEmpty
                            ? snapshot.data!
                            : filteredNewsList;
                        return ListView.separated(
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(height: 20);
                          },
                          scrollDirection: Axis.vertical,
                          padding: EdgeInsets.all(10),
                          itemCount: listNews.length,
                          itemBuilder: (Context, index) {
                            News currentNews = listNews[index];
                            return Container(
                              decoration: BoxDecoration(
                                color: const Color(
                                    0xff3b63ff), // Blue color for the background

                                border: Border.all(
                                  color: const Color(0xff3b63ff),
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(
                                      0xff3b63ff), // Green color with opacity of 1.0
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => NewsDetails(
                                            tit: Titles(
                                                title: listNews[index].title))),
                                  );
                                },
                                child: ListTile(
                                  leading: Icon(
                                    Icons.newspaper,
                                    color: Colors.white,
                                  ),
                                  title: Text(
                                    currentNews.title,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                    textDirection: TextDirection.rtl,
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void filterNews(String query) {
    setState(() {
      filteredNewsList = newsList
          .where(
              (news) => news.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }
}
