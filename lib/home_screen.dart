import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _TEC1 = TextEditingController();
  final TextEditingController _TEC2 = TextEditingController();

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  double _result = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Sum Calculator"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              TextFormField(
                controller: _TEC1,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(hintText: "First Number"),
                validator: (String? value) {
                  String v = value ?? '';
                  if (v.isEmpty) {
                    return "Enter Number one";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: _TEC2,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(hintText: "Second Number"),
                validator: (String? value) {
                  String v = value ?? '';
                  if (v.isEmpty) {
                    return "Enter Number two";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Expanded(
                      child: ElevatedButton(
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        double numOne = double.tryParse(_TEC1.text.trim()) ?? 0;
                        double numTwo = double.tryParse(_TEC2.text.trim()) ?? 0;
                        double result = add(numOne, numTwo);
                        _result = result;
                        setState(() {});
                      }
                    },
                    child: const Text("Add"),
                  )),
                  const SizedBox(
                    height: 16,
                  ),
                  Expanded(
                      child: ElevatedButton(
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        double numOne = double.tryParse(_TEC1.text.trim()) ?? 0;
                        double numTwo = double.tryParse(_TEC2.text.trim()) ?? 0;
                        double result = sub(numOne, numTwo);
                        _result = result;
                        setState(() {});
                      }
                    },
                    child: const Text("Sub"),
                  )),
                  const SizedBox(
                    height: 16,
                  ),
                  Expanded(
                      child: ElevatedButton(
                    onPressed: () {
                      clear();
                    },
                    child: Text("Clear"),
                  )),
                  SizedBox(
                    height: 16,
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                "Result = ${_result}",
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }

  void clear() {
    _TEC1.clear();
    _TEC2.clear();
    _result = 0;
    setState(() {});
  }

  double add(double num1, double num2) {
    return num1 + num2;
  }

  double sub(double num1, double num2) {
    return num1 - num2;
  }
}
