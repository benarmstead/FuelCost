import 'package:flutter/material.dart';
import 'cost_calculator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fuel Cost',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Fuel Cost Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double padding = 10;
  double width = 400;
  double height = 100;

  double cost = 0;
  var calc = CostCalculator();

  void rebuild() {
    if (calc.canCalculate()) {
      cost = calc.calculate();
    }
  }

  bool validatePassed(passed) {
    if (double.tryParse(passed) != null) {
      return true;
    }
    return false;
  }

  String getCost(multiplier) {
    // Ensures cost is rounded up and the maths off using the multiplier is sound.
    var costRounded = cost.toStringAsFixed(2);
    return (double.parse(costRounded) * multiplier).toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Container(
              constraints: BoxConstraints(minWidth: height, maxWidth: width),
              padding: EdgeInsets.all(padding),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(padding),
                      child: TextField(
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Distance"),
                        onChanged: (passed) => setState(() {
                          if (validatePassed(passed)) {
                            calc.setDistance(double.parse(passed));
                            rebuild();
                          }
                        }),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(padding),
                      child: TextField(
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(), labelText: "MPG"),
                        onChanged: (passed) => setState(() {
                          if (validatePassed(passed)) {
                            calc.setMpg(double.parse(passed));
                            rebuild();
                          }
                        }),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(padding),
                      child: TextField(
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Price Per Litre"),
                        onChanged: (passed) => setState(() {
                          if (validatePassed(passed)) {
                            calc.setPricePLitre(double.parse(passed));
                            rebuild();
                          }
                        }),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(padding),
                      child: Container(
                          width: width,
                          height: height - 50,
                          padding: EdgeInsets.all(padding),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.blue, width: 2.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(padding)),
                          ),
                          child: Text(
                            "One Way: £" + getCost(1),
                            style: const TextStyle(
                                fontSize: 18, color: Colors.black),
                            textAlign: TextAlign.center,
                          )),
                    ),
                    Padding(
                      padding: EdgeInsets.all(padding),
                      child: Container(
                          width: width,
                          height: height - 50,
                          padding: EdgeInsets.all(padding),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.blue, width: 2.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(padding)),
                          ),
                          child: Text(
                            "Return: £" + getCost(2),
                            style: const TextStyle(
                                fontSize: 18, color: Colors.black),
                            textAlign: TextAlign.center,
                          )),
                    ),
                  ])),
        ));
  }
}
