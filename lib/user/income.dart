import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:moukalaf/admin/firstpage.dart';
import 'package:moukalaf/admin/getclients.dart';
import 'package:moukalaf/main.dart';
import 'package:moukalaf/user/signup.dart';
import 'package:moukalaf/user/smartstart.dart';

Future<List<User>> setCalculator() async {
  var response =
      await http.post(Uri.http(ip, 'basic/web/calculator/set-calcul'), body: {
    "income": "$income",
    "deduction": "$deduction",
    "tax": "$tax",
    "percentage": "$percentage",
    "userId": "$IdSignup",
    "profit": "$profit",
    "year": "$year"
  });
  var jsonData = jsonDecode(response.body);

  print(jsonData);
  return userlist;
}

late bool isWifeWorks;

double profit = 0.0;
var percentage;
// ignore: prefer_typing_uninitialized_variables
var isPartnerWorking;
late int kidsNumber;

Future getUserWithJob($id) async {
  final queryParameters = {'id': $id.toString()};
  var response = await http
      .get(Uri.http(ip, 'basic/web/user/get-client-status', queryParameters));
  var jsonData = jsonDecode(response.body);
  percentage = jsonData['data'][0]['workPercentage'];
  isPartnerWorking = jsonData['data'][0]['isPartnerWorking'];
  print(jsonData);

  isWifeWorksFunction();
  return userlist;
}

isWifeWorksFunction() {
  if (isPartnerWorking == 1) {
    isWifeWorks = true;
  } else {
    isWifeWorks = false;
  }
}

List<int> YearList = List<int>.generate(10, (i) => i + 2018);
var year = YearList[4];
var tax = 0.0;
var income = 0;
var deductionMan = 0;
var deductionWoman = 0;
var deductionKids = 0;
var deduction = 0;
var taxable = 0.0;
switchDeduction() {
  switch (year) {
    case 2017:
    case 2018:
    case 2019:
    case 2020:
    case 2021:
      deductionMan = 7500000;
      isWifeWorks ? deductionWoman = 0 : deductionWoman = 2500000;
      deductionKids = 500000 * kidsNumber;
      print(isWifeWorks);

      break;
    case 2022:
    case 2023:
      deductionMan = 37500000;
      isWifeWorks ? deductionWoman = 0 : deductionWoman = 12500000;
      deductionKids = 2500000 * kidsNumber;
      print(isWifeWorks);

      break;
    case 2024:
    case 2025:
      deductionMan = 450000000;
      isWifeWorks ? deductionWoman = 0 : deductionWoman = 225000000;
      deductionKids = 45000000 * kidsNumber;
      print(isWifeWorks);
      break;
    default:
      print('choose a different number!');
  }
}

setDeduction() {
  deduction = deductionMan + deductionWoman + deductionKids;
  return deduction;
}

class Income extends StatefulWidget {
  const Income({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

TextEditingController incomeController = TextEditingController();

switchTax() {
  taxable = profit - deduction;

  if (year == 2017 || year == 2018) {
    profit = percentage / 100 * income;
    tax1();
  } else if (year == 2019 || year == 2020 || year == 2021) {
    profit = percentage / 100 * income;
    tax2();
  } else if (year >= 2022 && year < 2024) {
    profit = percentage / 100 * income * 0.4;
    tax3();
  } else if (year >= 2024 && year <= 2030) {
    profit = percentage / 100 * income;
    tax4();
  }
}

tax1() {
  if (taxable <= 0) {
    taxable = 0;
    tax = 0;
  } else if (taxable > 0 && taxable <= 9000000) {
    tax = taxable * 0.04;
  } else if (taxable > 9000000 && taxable <= 24000000) {
    tax = 360000 + (taxable - 9000000) * 0.07;
  } else if (taxable > 24000000 && taxable <= 54000000) {
    tax = 1410000 + (taxable - 24000000) * 0.12;
  } else if (taxable > 54000000 && taxable <= 104000000) {
    tax = 5010000 + (taxable - 54000000) * 0.16;
  } else if (taxable > 104000000 && taxable <= 225000000) {
    tax = 13010000 + (taxable - 104000000) * 0.21;
  } else if (taxable > 225000000) {
    tax = 38420000 + (taxable - 225000000) * 0.21;
  }
  return tax;
}

tax2() {
  if (taxable <= 0) {
    taxable = 0;
    tax = 0;
  } else if (taxable > 0 && taxable <= 9000000) {
    tax = taxable * 0.04;
  } else if (taxable > 9000000 && taxable <= 24000000) {
    tax = 360000 + (taxable - 9000000) * 0.07;
  } else if (taxable > 24000000 && taxable <= 54000000) {
    tax = 1410000 + (taxable - 24000000) * 0.12;
  } else if (taxable > 54000000 && taxable <= 104000000) {
    tax = 5010000 + (taxable - 54000000) * 0.16;
  } else if (taxable > 104000000 && taxable <= 225000000) {
    tax = 13010000 + (taxable - 104000000) * 0.21;
  } else if (taxable > 225000000) {
    tax = 38420000 + (taxable - 225000000) * 0.25;
  }
  return tax;
}

tax3() {
  if (taxable <= 0) {
    taxable = 0;

    tax = 0;
  } else if (taxable > 0 && taxable <= 27000000) {
    tax = taxable * 0.04;
  } else if (taxable > 27000000 && taxable <= 72000000) {
    tax = 1080000 + (taxable - 27000000) * 0.07;
  } else if (taxable > 72000000 && taxable <= 162000000) {
    tax = 4230000 + (taxable - 72000000) * 0.12;
  } else if (taxable > 162000000 && taxable <= 312000000) {
    tax = 15030000 + (taxable - 162000000) * 0.16;
  } else if (taxable > 312000000 && taxable <= 675000000) {
    tax = 39030000 + (taxable - 312000000) * 0.21;
  } else if (taxable > 675000000) {
    tax = 115260000 + (taxable - 675000000) * 0.25;
  }
  return tax;
}

tax4() {
  if (taxable <= 0) {
    taxable = 0;
    tax = 0;
  } else if (taxable > 0 && taxable <= 540000000) {
    tax = taxable * 0.04;
  } else if (taxable > 540000000 && taxable <= 1440000000) {
    tax = 21600000 + (taxable - 540000000) * 0.07;
  } else if (taxable > 1440000000 && taxable <= 3240000000) {
    tax = 84600000 + (taxable - 1440000000) * 0.12;
  } else if (taxable > 3240000000 && taxable <= 624000000) {
    tax = 300600000 + (taxable - 3240000000) * 0.16;
  } else if (taxable > 624000000 && taxable <= 13500000000) {
    tax = 780600000 + (taxable - 624000000) * 0.21;
  } else if (taxable > 13500000000) {
    tax = 2305200000 + (taxable - 13500000000) * 0.25;
  }
  return tax;
}
//

// ignore: prefer_typing_uninitialized_variables

NumberFormat myFormat = NumberFormat.decimalPattern('en_us');

class _HomePageState extends State<Income> {
  @override
  void initState() {
    super.initState();
    setState(() {
      percentage;
      print(percentage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              backgroundColor: x,
              centerTitle: true,
              title: Text(
                'احتساب الضريبة السنوبة على الأرباح',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
            body: SingleChildScrollView(
                child: FutureBuilder(
              future: getUserWithJob(IdSignup),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(60, 0, 0, 0),
                      child: Row(
                        children: [
                          DropdownButton<int>(
                            value: year,
                            icon: const Icon(Icons.arrow_drop_down),
                            elevation: 20,
                            style: const TextStyle(color: x, fontSize: 24),
                            underline: Container(
                              height: 2,
                              color: x,
                            ),
                            items: YearList.map<DropdownMenuItem<int>>(
                                (int value) {
                              return DropdownMenuItem<int>(
                                value: value,
                                child: Text(value.toString()),
                              );
                            }).toList(),
                            onChanged: (int? number) {
                              // This is called when the user selects an item.
                              setState(() {
                                year = number!;
                              });
                            },
                          ),
                          const SizedBox(
                            width: 45,
                          ),
                          // ignore: prefer_const_constructors
                          Text(
                            "         سنة التصريح",
                            style: const TextStyle(
                              color: x,
                              fontSize: 25,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // ignore: prefer_const_constructors
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: TextFormField(
                        textAlign: TextAlign.left,
                        controller: incomeController,
                        style: TextStyle(
                          fontSize: 20,
                          color: x,
                        ),
                        keyboardType: TextInputType.number,
                        cursorColor: x, // Set cursor color to blue
                        decoration: InputDecoration(
                          labelText: '                الايرادات السنوية ل.ل ',
                          labelStyle: TextStyle(
                            color: x,
                            fontSize: 20,
                            letterSpacing: 1,
                            fontWeight: FontWeight.bold,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(
                              color: x,
                              width: 2.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(
                              color: x,
                              width: 1.0,
                            ),
                          ),
                        ),
                      ),
                    ),

                    ListTile(
                      title: Text(
                        myFormat.format(income.round()),
                        style: TextStyle(
                          fontSize: 20,
                          color: const Color(0xff3b63ff),
                        ),
                      ),
                      trailing: Text(
                        " الايرادات السنوية ل.ل ",
                        style: TextStyle(fontSize: 24),
                      ),
                    ),

                    ListTile(
                      title: Text(
                        myFormat.format(profit.round()),
                        style: TextStyle(
                          fontSize: 20,
                          color: const Color(0xff3b63ff),
                        ),
                      ),
                      trailing: Text(
                        " الربح المقطوع ل.ل ",
                        style: TextStyle(fontSize: 25),
                      ),
                    ),

                    ListTile(
                      title: Text(
                        myFormat.format(deduction.round()),
                        style: TextStyle(
                          fontSize: 20,
                          color: const Color(0xff3b63ff),
                        ),
                      ),
                      trailing: Text(
                        " التنزبل العائلي ل.ل ",
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        myFormat.format(taxable.round()),
                        style: TextStyle(
                          fontSize: 20,
                          color: const Color(0xff3b63ff),
                        ),
                      ),
                      trailing: Text(
                        " المبلغ الخاضع ل.ل ",
                        style: TextStyle(fontSize: 25),
                      ),
                    ),

                    TextButton(
                      child: Text(
                        "  احتساب الضريبة",
                        style: TextStyle(
                          fontSize: 30,
                          color: const Color(0xff3b63ff),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          income = int.parse(incomeController.text);
                          switchDeduction();
                          setDeduction();
                          switchTax();
                          switchTax();
                        });
                      },
                    ),

                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 20,
                          color: const Color(0xff3b63ff),
                        ),
                      ),
                      width: 300,
                      height: 100,
                      child: Center(
                        child: Text(
                          myFormat.format(tax),
                          style: TextStyle(
                            fontSize: 30,
                            color: const Color(0xff3b63ff),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: TextButton(
                        child: Text(
                          "           Need A Help?\n Contact Business Consultant",
                          style: TextStyle(
                            fontSize: 20,
                            color: const Color(0xff3b63ff),
                          ),
                        ),
                        style: TextButton.styleFrom(),
                        onPressed: () {
                          setCalculator();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Smartstart()),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                  ]);
                }
                if (snapshot.hasError) {
                  print(snapshot.error.toString());
                  return Text('error');
                }
                return Center(
                    child: CircularProgressIndicator(
                  color: buttonColor,
                ));
              },
            )),
          ),
        ));
  }
}
