import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = "";
  double num1 = 0;
  double num2 = 0;
  String operand = "";

  buttonPressed(String buttonText) {
    if (buttonText == "CLEAR") {
      _output = "";
      num1 = 0;
      num2 = 0;
      operand = "";
    } else if (buttonText == "+" || buttonText == "-" || buttonText == "*" || buttonText == "/") {
      if (_output.isNotEmpty) {
        num1 = double.parse(_output);
        operand = buttonText;
        _output = "";
      }
    } else if (buttonText == "=") {
      if (_output.isNotEmpty && operand.isNotEmpty) {
        num2 = double.parse(_output);
        double result = 0;
        if (operand == "+") {
          result = num1 + num2;
        } else if (operand == "-") {
          result = num1 - num2;
        } else if (operand == "*") {
          result = num1 * num2;
        } else if (operand == "/") {
          result = num1 / num2;
        }
        _output = result.toString();
        num1 = result;
        num2 = 0;
        operand = "";
      }
    } else if (buttonText == "DEL") {
      if (_output.isNotEmpty) {
        _output = _output.substring(0, _output.length - 1);
      }
    } else {
      _output += buttonText;
    }

    setState(() {});
  }

  Widget buildButton(String buttonText, {Color? color}) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Material(
          color: color ?? Colors.grey[200],
          borderRadius: BorderRadius.circular(20.0),
          elevation: 5.0,
          child: InkWell(
            borderRadius: BorderRadius.circular(20.0),
            onTap: () => buttonPressed(buttonText),
            child: Center(
              child: Text(
                buttonText,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: color != null ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade400, Colors.blue.shade800],
          ),
        ),
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.only(bottom: 20.0),
              child: Text(
                _output,
                style: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                buildButton("7"),
                buildButton("8"),
                buildButton("9"),
                buildButton("/", color: Colors.orange),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                buildButton("4"),
                buildButton("5"),
                buildButton("6"),
                buildButton("*", color: Colors.orange),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                buildButton("1"),
                buildButton("2"),
                buildButton("3"),
                buildButton("-", color: Colors.orange),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                buildButton("."),
                buildButton("0"),
                buildButton("DEL", color: Colors.red),
                buildButton("+", color: Colors.orange),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                buildButton("CLEAR", color: Colors.red),
                buildButton("="),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
