// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';
import 'package:dart_eval/dart_eval.dart';

void main() {
  runApp(const MyApp());
}

double space = 2;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Calculator",
            style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
          ),
          backgroundColor: const Color.fromRGBO(0, 0, 255, 1),
        ),
        body: const CalculatorBody(),
      ),
    );
  }
}

class CalculatorBody extends StatefulWidget {
  const CalculatorBody({super.key});

  @override
  State<CalculatorBody> createState() => _CalculatorBodyState();
}

class _CalculatorBodyState extends State<CalculatorBody> {
  String expression = "0";
  String result = "0";
  String errorMsg = "";

  void addNewDigit(String d) {
    if (expression == "0") {
      setState(() {
        expression = "";
      });
    }
    if (d == "()") {
      setState(() {
        expression += "()";
      });
    } else if (d == "x") {
      setState(() {
        expression += "*";
      });
    } else {
      setState(() {
        expression += d;
      });
    }
  }

  void clearScreen() {
    setState(() {
      expression = "0";
      result = "0";
    });
  }

  bool isNumeric(String str) {
    try {
      // ignore: unused_local_variable
      var value = double.parse(str);
      return true;
    } catch (e) {
      return false;
    }
  }

  void delDigitAtPos(int pos) {
    if (isNumeric(result)) {
      if (expression.length == 1) {
        setState(() {
          expression = "0";
        });
      } else {
        if (expression.isNotEmpty) {
          setState(() {
            expression = expression.substring(0, expression.length - 1);
          });
        }
      }
    } else {
      if (expression.length == 1) {
        setState(() {
          expression = "0";
        });
      } else {
        if (expression.isNotEmpty) {
          setState(() {
            expression = expression.substring(0, expression.length - 1);
          });
        }
      }
      result = "0";
    }
  }

  void calculate() {
    try {
      setState(() {
        result = eval(expression).toString();
      });
    } catch (e) {
      setState(() {
        result = "Error";
      });
    }
  }

  Widget customButton(String l, {MaterialColor c = Colors.grey}) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 10,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: c,
            shape: const BeveledRectangleBorder(),
          ),
          onPressed: () {
            if (l == "C") {
              clearScreen();
            } else if (l == "DEL") {
              delDigitAtPos(0);
            } else if (l == "=") {
              calculate();
            } else {
              addNewDigit(l);
            }
          },
          child: Text(
            l,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 100,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          expression,
                          style: const TextStyle(fontSize: 25),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        "=",
                        style: const TextStyle(fontSize: 25),
                      ),
                      Expanded(
                        child: Text(
                          result,
                          style: const TextStyle(fontSize: 40),
                          textAlign: TextAlign.right,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              child: Container(
                alignment: AlignmentDirectional.bottomCenter,
                constraints: const BoxConstraints.expand(),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(space, space, space, 2 * space),
                  child: Table(
                    children: [
                      TableRow(
                        children: [
                          customButton(
                            "C",
                            c: Colors.red,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2),
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height / 10,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(right: space / 2),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.blue,
                                          shape: const BeveledRectangleBorder(),
                                        ),
                                        onPressed: () {
                                          addNewDigit("(");
                                        },
                                        child: const Text(
                                          "(",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(left: space / 2),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.blue,
                                          shape: const BeveledRectangleBorder(),
                                        ),
                                        onPressed: () {
                                          addNewDigit(")");
                                        },
                                        child: const Text(
                                          ")",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          customButton(
                            "%",
                            c: Colors.blue,
                          ),
                          customButton(
                            "DEL",
                            c: Colors.blue,
                          )
                        ],
                      ),
                      TableRow(
                        children: [
                          customButton(
                            "7",
                          ),
                          customButton(
                            "8",
                          ),
                          customButton(
                            "9",
                          ),
                          customButton(
                            "/",
                            c: Colors.blue,
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          customButton(
                            "6",
                          ),
                          customButton(
                            "5",
                          ),
                          customButton(
                            "3",
                          ),
                          customButton(
                            "x",
                            c: Colors.blue,
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          customButton(
                            "1",
                          ),
                          customButton(
                            "2",
                          ),
                          customButton(
                            "3",
                          ),
                          customButton(
                            "-",
                            c: Colors.blue,
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          customButton(
                            "0",
                          ),
                          customButton(
                            ".",
                          ),
                          customButton(
                            "=",
                            c: Colors.red,
                          ),
                          customButton(
                            "+",
                            c: Colors.blue,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
