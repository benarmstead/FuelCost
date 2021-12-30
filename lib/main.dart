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
  final CostCalculator calc = CostCalculator();
  double cost = 0;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Container(
              constraints: const BoxConstraints(minWidth: 100, maxWidth: 400),
              padding: const EdgeInsets.all(10),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        keyboardType: TextInputType.number,
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
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        keyboardType: TextInputType.number,
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
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        keyboardType: TextInputType.number,
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
                      padding: const EdgeInsets.all(8.0),
                      child: Text("One Way: £" + cost.toStringAsFixed(2)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Return: £" + (cost * 2).toStringAsFixed(2)),
                    ),
                  ])),
        ));
  }
}
