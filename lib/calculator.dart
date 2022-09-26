// ignore_for_file: deprecated_member_use, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  Widget calButton(String btnTxt, Color btnColor, Color txtColor) {
    return RaisedButton(
      onPressed: (() {
        calculation(btnTxt);
      }),
      shape: CircleBorder(),
      color: btnColor,
      padding: EdgeInsets.all(20.0),
      child: Text(
        btnTxt,
        style: TextStyle(
          color: txtColor,
          fontSize: 25.0,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        centerTitle: true,
        title: Text("calculator"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.0, vertical: 20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(
                      child: Text(
                    '$text',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 100.0, color: Colors.white),
                  ))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  calButton("AC", Colors.green, Colors.black87),
                  calButton("-/+", Colors.green, Colors.black87),
                  calButton("%", Colors.green, Colors.black87),
                  calButton("/", Colors.green, Colors.black87),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  calButton("9", Colors.green, Colors.black87),
                  calButton("8", Colors.green, Colors.black87),
                  calButton("7", Colors.green, Colors.black87),
                  calButton("*", Colors.green, Colors.black87),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  calButton("6", Colors.green, Colors.black87),
                  calButton("5", Colors.green, Colors.black87),
                  calButton("4", Colors.green, Colors.black87),
                  calButton("-", Colors.green, Colors.black87),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  calButton("3", Colors.green, Colors.black87),
                  calButton("2", Colors.green, Colors.black87),
                  calButton("1", Colors.green, Colors.black87),
                  calButton("+", Colors.green, Colors.black87),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RaisedButton(
                    onPressed: (() {
                      calculation('0');
                    }),
                    shape: CircleBorder(),
                    color: Colors.grey[850],
                    child: Text(
                      '0',
                      style: TextStyle(fontSize: 60, color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  calButton('.', Colors.green, Colors.black87),
                  calButton('=', Colors.amber, Colors.deepOrange)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  dynamic text = '0';
  double firstNum = 0;
  double secNum = 0;
  dynamic opr = '';
  dynamic preOpr = '';

  dynamic result = '';
  dynamic finalresult = '';

  void calculation(btnTxt) {
    if (btnTxt == "AC") {
      text = '0';
      firstNum = 0;
      secNum = 0;
      result = '';
      finalresult = '';
      opr = '';
      preOpr = '';
    } else if (opr == '=' && btnTxt == '=') {
      if (preOpr == '+') {
        finalresult = add();
      } else if (preOpr == '-') {
        finalresult = sub();
      } else if (preOpr == '*') {
        finalresult = mul();
      } else if (preOpr == '/') {
        finalresult = div();
      }
    } else if (btnTxt == '+' ||
        btnTxt == '-' ||
        btnTxt == '*' ||
        btnTxt == '/' ||
        btnTxt == '=') {
      if (firstNum == 0) {
        firstNum = double.parse(result);
      } else {
        secNum = double.parse(result);
      }
      if (opr == '+') {
        finalresult = add();
      } else if (opr == '-') {
        finalresult = sub();
      } else if (opr == '*') {
        finalresult = mul();
      } else if (opr == '/') {
        finalresult = div();
      }
      preOpr = opr;
      opr = btnTxt;
      result = '';
    } else if (btnTxt == '%') {
      result = firstNum / 100;
      finalresult = doesContainDecimal(result);
    } else if (btnTxt == '.') {
      if (result.toString().contains('.')) {
        result = '$result';
      }
      finalresult = result;
    } else if (btnTxt == '-/+') {
      result.toString().startsWith('-')
          ? result.toString().substring(1)
          : result = '-$result';
      finalresult = result;
    } else {
      result = result + btnTxt;
      finalresult = result;
    }
    setState(() {
      text = finalresult;
    });
  }

  String add() {
    result = (firstNum + secNum).toString();
    firstNum = double.parse(result);
    return doesContainDecimal(result);
  }

  String sub() {
    result = (firstNum - secNum).toString();
    firstNum = double.parse(result);
    return doesContainDecimal(result);
  }

  String mul() {
    result = (firstNum * secNum).toString();
    firstNum = double.parse(result);
    return doesContainDecimal(result);
  }

  String div() {
    result = (firstNum / secNum).toString();
    firstNum = double.parse(result);
    return doesContainDecimal(result);
  }

  String doesContainDecimal(dynamic result) {
    if (result.toString().contains('.')) {
      List<String> splltdecimal = result.toString().split('.');
      if (int.parse(splltdecimal[1]) > 0) {
        return result = splltdecimal[0].toString();
      }
    }
    return result;
  }
}
