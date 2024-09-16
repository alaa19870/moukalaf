import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moukalaf/main.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

int percentage = 0;
List<int> percentageList = Iterable<int>.generate(61).toList();
bool isMarried = false;
String $isMarriedTinyInt = "0";
bool isWifeWorks = false;
String $isWifeWorksTinyInt = "0";
const List<int> kidsList = <int>[0, 1, 2, 3, 4, 5];
List<int> yearList = List<int>.generate(10, (i) => i + 2017);
var year = yearList[5];

setTinyInt() {
  if (isMarried) {
    $isMarriedTinyInt = "1";
  }
  ;
  if (isWifeWorks) {
    $isWifeWorksTinyInt = "1";
  }
}

bool percentageVariable = true;

int KidsNumber = kidsList.first;
TextEditingController incomeController = TextEditingController();
var tax = 0.0;
var income = 0;
var deductionMan = 0;
var deductionWoman = 0;
var deductionKids = 0;
var deduction = 0;
var taxable = 0.0;
var edge = 0.0;

switchDeduction() {
  switch (year) {
    case 2017:
    case 2018:
    case 2019:
    case 2020:
    case 2021:
      print('lower!');
      deductionMan = 7500000;
      isWifeWorks ? deductionWoman = 0 : deductionWoman = 2500000;
      deductionKids = 500000 * KidsNumber;
      break;
    case 2022:
    case 2023:
      print('higher!');
      deductionMan = 37500000;
      isWifeWorks ? deductionWoman = 0 : deductionWoman = 12500000;
      deductionKids = 2500000 * KidsNumber;
      break;
    case 2024:
    case 2025:
    case 2026:
      deductionMan = 450000000;
      isWifeWorks ? deductionWoman = 0 : deductionWoman = 225000000;
      deductionKids = 45000000 * KidsNumber;
      break;

    default:
      print('choose a different number!');
  }
}

setDeduction() {
  deduction = deductionMan + deductionWoman + deductionKids;
  return deduction;
}

setEdge() {
  if (percentage != 0) {
    switch (year) {
      case 2017:
      case 2018:
      case 2019:
      case 2020:
      case 2021:
      case 2024:
      case 2025:
      case 2026:
        edge = deduction / (percentage / 100);
        break;

      case 2022:
      case 2023:
        edge = deduction / (percentage * 0.4 / 100);
        break;

      default:
    }

    return edge;
  } else {
    // Handle the case where percentage is zero (do nothing or add specific logic)
    return null; // or any other suitable value
  }
}

double profit = 0;
NumberFormat myFormat = NumberFormat.decimalPattern('en_us');

setTax() {
  switch (year) {
    case 2017:
    case 2018:
      print('lower!');
      profit = percentage / 100 * income;
      taxable = profit - setDeduction();
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

    case 2019:
    case 2020:
    case 2021:
      profit = percentage / 100 * income;
      taxable = profit - setDeduction();
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
    case 2022:
    case 2023:
      print('higher!');
      profit = percentage / 100 * income * 0.4;
      taxable = profit - setDeduction();
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
    case 2024:
    case 2025:
    case 2026:
      print('higher!');
      profit = percentage / 100 * income;
      taxable = profit - setDeduction();
      if (taxable <= 0) {
        taxable = 0;
        tax = 0;
      } else if (taxable > 0 && taxable <= 540000000) {
        tax = taxable * 0.04;
      } else if (taxable > 540000000 && taxable <= 1440000000) {
        tax = 21600000 + (taxable - 540000000) * 0.07;
      } else if (taxable > 1440000000 && taxable <= 3240000000) {
        tax = 84600000 + (taxable - 1440000000) * 0.12;
      } else if (taxable > 3240000000 && taxable <= 6240000000) {
        tax = 300600000 + (taxable - 3240000000) * 0.16;
      } else if (taxable > 6240000000 && taxable <= 13500000000) {
        tax = 780600000 + (taxable - 6240000000) * 0.21;
      } else if (taxable > 13500000000) {
        tax = 2305200000 + (taxable - 13500000000) * 0.25;
      }
      return tax;

    default:
      print('choose a different number!');
  }
}

class _HomePageState extends State<Calculator> {
  @override
  void initState() {
    super.initState();
    percentage = percentageList.first;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Lora',
      ),
      home: SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.0),
            child: AppBar(
              centerTitle: true,
              backgroundColor: x,
              title: Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Text(
                  'احتساب ضريبة دخل الأفراد',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DropdownButton<int>(
                      value: year,
                      icon: const Icon(Icons.arrow_drop_down),
                      elevation: 20,
                      style: const TextStyle(
                        color: x,
                        fontSize: 24,
                      ),
                      underline: Container(
                        height: 2,
                        color: x,
                      ),
                      items: yearList.map<DropdownMenuItem<int>>(
                        (int value) {
                          return DropdownMenuItem<int>(
                            value: value,
                            child: Text(value.toString()),
                          );
                        },
                      ).toList(),
                      onChanged: (int? number) {
                        setState(() {
                          year = number!;
                        });
                      },
                    ),
                    Text(
                      "         سنة التصريح",
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.center, // Align content to the right
                  children: [
                    Text(
                      myFormat.format(edge.round()),
                      style: TextStyle(
                        fontSize: 12,
                        color: x,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "عتبة الضريبة ل.ل",
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      textAlign: TextAlign.left,
                      controller: incomeController,
                      style: TextStyle(
                        fontSize: 20,
                        color: x, // Text color blue
                      ),
                      keyboardType: TextInputType.number,
                      cursorColor: x, // Cursor color blue

                      decoration: InputDecoration(
                        // hoverColor: x,
                        labelText: '                الايرادات السنوية ل.ل ',
                        labelStyle: TextStyle(
                          color: x,
                          fontSize: 20,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold,
                        ),
                        hintText: '', // Add a hint text
                        hintStyle: TextStyle(
                          color: x, // Hint color blue
                        ),
                        fillColor: x,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(
                            color: x, // Border color blue
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(
                            color: const Color(
                                0xff3b63ff), // Enabled border color blue
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(
                            color: const Color(
                                0xff3b63ff), // Focused border color blue
                          ),
                        ),
                      ),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment
                      .spaceAround, // Align content to the right
                  children: [
                    Text(
                      myFormat.format(income.round()),
                      style: TextStyle(
                        fontSize: 18,
                        color: x,
                      ),
                    ),
                    Text(
                      " الايرادات السنوية ل.ل ",
                      style: TextStyle(fontSize: 24),
                    ),
                  ],
                ),
                Visibility(
                  visible: percentageVariable,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment
                        .spaceAround, // Align content to the right
                    children: [
                      DropdownButton<int>(
                        value: percentage,
                        icon: const Icon(Icons.arrow_drop_down),
                        elevation: 15,
                        style: const TextStyle(
                          color: x,
                          fontSize: 20,
                        ),
                        underline: Container(
                          height: 2,
                          color: x,
                        ),
                        items: percentageList.map<DropdownMenuItem<int>>(
                          (int value) {
                            return DropdownMenuItem<int>(
                              value: value,
                              child: Text(value.toString()),
                            );
                          },
                        ).toList(),
                        onChanged: (int? number) {
                          setState(() {
                            percentage = number!;
                            profit;
                          });
                        },
                      ),
                      Text(
                        "% نسبة الربح المقطوع",
                        style: TextStyle(fontSize: 25),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment
                      .spaceAround, // Align content to the right
                  children: [
                    Container(
                      width: 150,
                      child: Text(
                        myFormat.format(profit.round()),
                        style: TextStyle(
                          fontSize: 20,
                          color: x,
                        ),
                      ),
                    ),
                    Text(
                      " الربح المقطوع ل.ل ",
                      style: TextStyle(fontSize: 25),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment
                      .spaceAround, // Align content to the right
                  children: [
                    Text(
                      myFormat.format(deduction.round()),
                      style: TextStyle(
                        fontSize: 20,
                        color: x,
                      ),
                    ),
                    Text(
                      " التنزبل العائلي ل.ل ",
                      style: TextStyle(fontSize: 25),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment
                      .spaceAround, // Align content to the right
                  children: [
                    Text(
                      myFormat.format(taxable.round()),
                      style: TextStyle(
                        fontSize: 20,
                        color: x,
                      ),
                    ),
                    Text(
                      " المبلغ الخاضع ل.ل ",
                      style: TextStyle(fontSize: 24),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment
                      .spaceAround, // Align content to the right
                  children: [
                    Transform.scale(
                      scale: 1.5,
                      child: Checkbox(
                        value: isMarried,
                        onChanged: (value) {
                          setState(() {
                            isMarried = value!;
                            isMarried ? isWifeWorks : isWifeWorks = false;
                            isMarried ? KidsNumber : KidsNumber = 0;
                            switchDeduction();
                          });
                          print(deductionMan);
                        },
                        activeColor: x, // Set the active color to blue
                      ),
                    ),
                    Text(
                      "هل انت متزوج(ة)؟",
                      style: TextStyle(fontSize: 25),
                    ),
                  ],
                ),
                Visibility(
                  visible: isMarried,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment
                        .spaceAround, // Align content to the right
                    children: [
                      Transform.scale(
                        scale: 1.5,
                        child: Checkbox(
                          value: isWifeWorks,
                          onChanged: (value) {
                            setState(() {
                              isWifeWorks = value!;
                              switchDeduction();
                            });
                            print(deductionWoman);
                          },
                          activeColor: x, // Set the active color to blue
                        ),
                      ),
                      Text(
                        "هل الزوج(ة) تعمل ؟",
                        style: TextStyle(fontSize: 25),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: isMarried,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment
                        .spaceAround, // Align content to the right
                    children: [
                      DropdownButton<int>(
                        value: KidsNumber,
                        icon: const Icon(Icons.arrow_drop_down),
                        elevation: 15,
                        style: const TextStyle(
                          color: x,
                          fontSize: 20,
                        ),
                        underline: Container(
                          height: 2,
                          color: x,
                        ),
                        items: kidsList.map<DropdownMenuItem<int>>(
                          (int value) {
                            return DropdownMenuItem<int>(
                              value: value,
                              child: Text(value.toString()),
                            );
                          },
                        ).toList(),
                        onChanged: (int? number) {
                          setState(() {
                            KidsNumber = number!;
                            switchDeduction();
                          });
                          print(deductionKids);
                        },
                      ),
                      Text(
                        "عدد الأولاد على عاتقكم؟",
                        style: TextStyle(fontSize: 22),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  child: Text(
                    "  احتساب الضريبة",
                    style: TextStyle(
                      fontSize: 30,
                      color: x,
                    ),
                  ),
                  style: TextButton.styleFrom(),
                  onPressed: () {
                    setState(() {
                      isMarried ? isWifeWorks : isWifeWorks = true;
                      isMarried ? KidsNumber : KidsNumber = 0;
                      KidsNumber;
                      switchDeduction();
                      setDeduction();
                      print(setDeduction());
                      setEdge();
                      print(setEdge());
                      income = incomeController.text.isEmpty
                          ? 0
                          : int.parse(incomeController.text);
                      setTax();
                      print(setTax());
                    });
                  },
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 20,
                      color: x,
                    ),
                  ),
                  width: 300,
                  height: 100,
                  child: Center(
                    child: Text(
                      myFormat.format(tax),
                      style: TextStyle(
                        fontSize: 30,
                        color: x,
                      ),
                    ),
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
