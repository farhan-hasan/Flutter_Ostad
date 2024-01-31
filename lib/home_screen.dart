import 'package:flutter/material.dart';
import 'water_consumed.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<WaterConsumed> waterConsumeList = [];
  final TextEditingController _noOfGlassesTEC =
      TextEditingController(text: '1');
  final TextEditingController _noteTEC = TextEditingController(text: 'Morning');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        foregroundColor: Colors.white,
        title: const Text("Water Tracker"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(100),
                    onTap: () {
                      if (_noOfGlassesTEC.text.trim().isEmpty) {
                        _noOfGlassesTEC.text = '1';
                      }
                      final noOfGlasses = _noOfGlassesTEC.text.trim();
                      int value = int.tryParse(noOfGlasses) ?? 1;
                      waterConsumeList
                          .insert(0, WaterConsumed(value, DateTime.now(), _noteTEC.text));
                      setState(() {});
                    },
                    child: Container(
                      height: 100,
                      width: 100,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.lightBlueAccent,
                          border: Border.all(color: Colors.lightBlue, width: 4),
                          borderRadius: BorderRadius.circular(100)),
                      child: const Text(
                        "Drink",
                        style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16,),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    SizedBox(
                      width: 50,
                      child: TextField(
                        controller: _noOfGlassesTEC,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    SizedBox(
                      width: 200,
                      child: TextField(
                        controller: _noteTEC,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ])
                ],
              ),
            ),
            ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: waterConsumeList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text(waterConsumeList[index].noOfGlass.toString()),
                    ),
                    title: Text(waterConsumeList[index].note),
                    subtitle: Text(DateFormat.yMEd().add_jms().format(waterConsumeList[index].time)),
                    trailing: IconButton(
                      icon: Icon(Icons.delete_outline),
                      onPressed: () {
                        waterConsumeList.removeAt(index);
                        setState(() {

                        });
                      },
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
