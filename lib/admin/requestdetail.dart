import 'package:flutter/material.dart';

class ItemCalculator {
  final String year;
  final String name;
  final String telephone;
  final String email;
  final String personnelNumber;
  final String financialNumber;
  final String homeAdress;
  final String workAdress;
  final String job;
  late final String isMarried;
  final String isPartnerWorking;
  final String kidsNumber;
  final String income;
  final String deduction;
  final String profit;
  final String percentage;
  final String tax;

  ItemCalculator({
    required this.year,
    required this.name,
    required this.telephone,
    required this.email,
    required this.personnelNumber,
    required this.financialNumber,
    required this.homeAdress,
    required this.workAdress,
    required this.job,
    required this.isMarried,
    required this.isPartnerWorking,
    required this.kidsNumber,
    required this.income,
    required this.deduction,
    required this.profit,
    required this.percentage,
    required this.tax,
  });
}

class ItemDetails extends StatelessWidget {
  final ItemCalculator calculator;

  ItemDetails({required this.calculator});

  @override
  Widget build(BuildContext context) {
    bool married;
    bool partnerWorking;

    if (calculator.isMarried == '0') {
      married = false;
    } else {
      married = true;
    }
    if (calculator.isMarried == '0') {
      partnerWorking = false;
    } else {
      partnerWorking = true;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff3b63ff),
        centerTitle: true,
        title: Text(
          calculator.name,
          style: TextStyle(fontSize: 20.0, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ListTile(
                  trailing: Text(
                    "سنة التصريح",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: const Color(0xff3b63ff),
                    ),
                  ),
                  leading: Icon(Icons.date_range),
                  title: Text(
                    calculator.year,
                    style: TextStyle(
                        fontSize: 16.0, color: const Color(0xff3b63ff)),
                  ),
                ),
                ListTile(
                  trailing: Text(
                    "مهنة المكلف",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: const Color(0xff3b63ff),
                    ),
                  ),
                  leading: Icon(Icons.work),
                  title: Text(
                    calculator.job,
                    style: TextStyle(
                        fontSize: 16.0, color: const Color(0xff3b63ff)),
                  ),
                ),
                ListTile(
                  trailing: Text(
                    "عنوان سكن",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: const Color(0xff3b63ff),
                    ),
                  ),
                  leading: Icon(Icons.home),
                  title: Text(
                    calculator.homeAdress,
                    style: TextStyle(
                        fontSize: 16.0, color: const Color(0xff3b63ff)),
                  ),
                ),
                ListTile(
                  trailing: Text(
                    "عنوان عمل",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: const Color(0xff3b63ff),
                    ),
                  ),
                  leading: Icon(Icons.business),
                  title: Text(
                    calculator.workAdress,
                    style: TextStyle(
                        fontSize: 16.0, color: const Color(0xff3b63ff)),
                  ),
                ),
                ListTile(
                  trailing: Text(
                    "رقم هاتف",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: const Color(0xff3b63ff),
                    ),
                  ),
                  leading: Icon(Icons.call),
                  title: Text(
                    calculator.telephone,
                    style: TextStyle(
                        fontSize: 16.0, color: const Color(0xff3b63ff)),
                  ),
                ),
                ListTile(
                  trailing: Text(
                    "رقم الشخصي",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: const Color(0xff3b63ff),
                    ),
                  ),
                  leading: Icon(Icons.perm_identity),
                  title: Text(
                    calculator.personnelNumber,
                    style: TextStyle(
                        fontSize: 16.0, color: const Color(0xff3b63ff)),
                  ),
                ),
                ListTile(
                  trailing: Text(
                    "رقم المهنة-المؤسسة",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: const Color(0xff3b63ff),
                    ),
                  ),
                  leading: Icon(Icons.business),
                  title: Text(
                    calculator.financialNumber,
                    style: TextStyle(
                        fontSize: 16.0, color: const Color(0xff3b63ff)),
                  ),
                ),
                ListTile(
                  trailing: Text(
                    "البريد الالكتروني",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: const Color(0xff3b63ff),
                    ),
                  ),
                  leading: Icon(Icons.email),
                  title: Text(
                    calculator.email,
                    style: TextStyle(
                        fontSize: 16.0, color: const Color(0xff3b63ff)),
                  ),
                ),
                ListTile(
                  trailing: Text(
                    " ?هل متزوج(ة)",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: const Color(0xff3b63ff),
                    ),
                  ),
                  leading: Icon(Icons.girl),
                  title: Text(
                    married ? 'متزوج' : 'غير متزوج',
                    style: TextStyle(
                        fontSize: 16.0, color: const Color(0xff3b63ff)),
                  ),
                ),
                ListTile(
                  trailing: Text(
                    " ?هل زوج(ة) يعمل",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: const Color(0xff3b63ff),
                    ),
                  ),
                  leading: Icon(Icons.girl),
                  title: Text(
                    partnerWorking ? 'زوج(ة) يعمل' : 'زوج(ة) لا يعمل',
                    style: TextStyle(
                        fontSize: 16.0, color: const Color(0xff3b63ff)),
                  ),
                ),
                ListTile(
                  trailing: Text(
                    "عدد الأولاد على عاتق المكلف",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: const Color(0xff3b63ff),
                    ),
                  ),
                  leading: Icon(Icons.child_friendly),
                  title: Text(
                    calculator.kidsNumber,
                    style: TextStyle(
                        fontSize: 16.0, color: const Color(0xff3b63ff)),
                  ),
                ),
                ListTile(
                  trailing: Text(
                    "الايرادات المقدرة",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: const Color(0xff3b63ff),
                    ),
                  ),
                  leading: Icon(Icons.money),
                  title: Text(
                    calculator.income,
                    style: TextStyle(
                        fontSize: 16.0, color: const Color(0xff3b63ff)),
                  ),
                ),
                ListTile(
                  trailing: Text(
                    "الارباح المقدرة",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: const Color(0xff3b63ff),
                    ),
                  ),
                  leading: Icon(Icons.money),
                  title: Text(
                    calculator.profit,
                    style: TextStyle(
                        fontSize: 16.0, color: const Color(0xff3b63ff)),
                  ),
                ),
                ListTile(
                  trailing: Text(
                    "التنزيل العائلي",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: const Color(0xff3b63ff),
                    ),
                  ),
                  leading: Icon(Icons.remove),
                  title: Text(
                    calculator.deduction,
                    style: TextStyle(
                        fontSize: 16.0, color: const Color(0xff3b63ff)),
                  ),
                ),
                ListTile(
                  trailing: Text(
                    "نسبة الربح المقطوع",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: const Color(0xff3b63ff),
                    ),
                  ),
                  leading: Icon(Icons.percent),
                  title: Text(
                    calculator.percentage,
                    style: TextStyle(
                        fontSize: 16.0, color: const Color(0xff3b63ff)),
                  ),
                ),
                ListTile(
                  trailing: Text(
                    "الضريبة المتوجبة",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: const Color(0xff3b63ff),
                    ),
                  ),
                  leading: Icon(Icons.payment),
                  title: Text(
                    calculator.tax,
                    style: TextStyle(
                        fontSize: 16.0, color: const Color(0xff3b63ff)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
