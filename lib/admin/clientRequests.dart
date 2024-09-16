import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:moukalaf/admin/firstpage.dart';
import 'package:moukalaf/admin/requestdetail.dart';

class Declare {
  late String name,
      telephone,
      email,
      jobName,
      isMarried,
      isPartnerWorking,
      kidsNumber,
      personnelNumber,
      financialNumber,
      homeAdress,
      workAdress,
      id,
      year,
      income,
      deduction,
      tax,
      percentage,
      profit;
  Declare(
      this.name,
      this.telephone,
      this.email,
      this.jobName,
      this.isMarried,
      this.isPartnerWorking,
      this.kidsNumber,
      this.personnelNumber,
      this.financialNumber,
      this.homeAdress,
      this.workAdress,
      this.id,
      this.year,
      this.income,
      this.deduction,
      this.tax,
      this.percentage,
      this.profit);
}

List<Declare> calculatorList = [];
Future<List<Declare>> getCalculatorsByAdmin($id) async {
  calculatorList.clear();
  final queryParameters = {'admin': $id.toString()};
  var response = await http.get(Uri.http(
      ip,
      'basic/web/calculator/get-calculators-by-administrator',
      queryParameters));
  var jsonData = jsonDecode(response.body);
  for (var u in jsonData['data']) {
    Declare declare = Declare(
      u["name"],
      u["telephone"].toString(),
      u["email"],
      u["workName"].toString(),
      u["isMarried"].toString(),
      u["isPartnerWorking"].toString(),
      u["kidsNumber"].toString(),
      u["personnelNumber"].toString(),
      u["financialNumber"].toString(),
      u["homeAdress"],
      u["workAdress"],
      u["id"].toString(),
      u["year"].toString(),
      u["income"].toString(),
      u["deduction"].toString(),
      u["tax"].toString(),
      u["percentage"].toString(),
      u["profit"].toString(),
    );
    calculatorList.add(declare);
  }
  print(jsonData);
  return calculatorList;
}

class AdminCalculators extends StatefulWidget {
  const AdminCalculators({super.key});
  @override
  State<AdminCalculators> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<AdminCalculators> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(
            0xff3b63ff), // Sets the default primary color for the app

        fontFamily: 'Lora',
      ),
      home: SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
              preferredSize:
                  const Size.fromHeight(50.0), // here the desired height
              child: AppBar(
                centerTitle: true,
                backgroundColor: const Color(0xff3b63ff),
                title: const Padding(
                  padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                  child: Text(
                    'طلبات تصريح مكلفين ',
                    style: TextStyle(fontFamily: 'Lora', color: Colors.white),
                  ),
                ),
              )),
          body: Directionality(
            textDirection:
                TextDirection.rtl, // Set text direction to right-to-left
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height,
                      minHeight: MediaQuery.of(context).size.height,
                    ),
                    child: FutureBuilder<List<Declare>>(
                      future: getCalculatorsByAdmin(adminId),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<Declare> calculators =
                              snapshot.data as List<Declare>;
                          print(calculators.length);

                          return ListView.separated(
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return SizedBox(height: 20);
                            },
                            scrollDirection: Axis.vertical,
                            padding: EdgeInsets.all(30),
                            itemCount: calculators.length,
                            itemBuilder: (context, index) {
                              return Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: ListTile(
                                  leading: Icon(
                                    color: Colors.blue, // Set the color to blue

                                    Icons.chat,
                                    size: 32, // Set the desired size here
                                  ),
                                  title: Text(
                                    calculators[index].name,
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: const Color(0xff3b63ff),
                                    ),
                                  ),
                                  subtitle: Text(
                                    "${calculators[index].income} ل.ل.",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  trailing: Icon(
                                    Icons.arrow_forward,
                                    color: const Color(0xff3b63ff),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ItemDetails(
                                          calculator: ItemCalculator(
                                            year: calculators[index].year,
                                            name: calculators[index].name,
                                            telephone:
                                                calculators[index].telephone,
                                            email: calculators[index].email,
                                            personnelNumber: calculators[index]
                                                .personnelNumber,
                                            financialNumber: calculators[index]
                                                .financialNumber,
                                            homeAdress:
                                                calculators[index].homeAdress,
                                            workAdress:
                                                calculators[index].workAdress,
                                            job: calculators[index].jobName,
                                            isMarried:
                                                calculators[index].isMarried,
                                            isPartnerWorking: calculators[index]
                                                .isPartnerWorking,
                                            kidsNumber:
                                                calculators[index].kidsNumber,
                                            income: calculators[index].income,
                                            deduction:
                                                calculators[index].deduction,
                                            percentage:
                                                calculators[index].percentage,
                                            profit: calculators[index].profit,
                                            tax: calculators[index].tax,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          );
                        }
                        if (snapshot.hasError) {
                          print(snapshot.error.toString());
                          return Text('error');
                        }
                        return Center(
                          child: CircularProgressIndicator(
                            color: Colors.blue, // Set the color to blue
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
