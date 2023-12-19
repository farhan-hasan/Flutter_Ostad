import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo app',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {

  TextEditingController searchTextFieldController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                print("Tapped Hello button");
              },
              child: Text("Hello"),
              onLongPress: () {
                print("Long Tapped Hello button");
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  // minimumSize: Size(300, 40),
                  // maximumSize: Size(300, 40),
                  padding: EdgeInsets.all(50),
                  elevation: 10,
                  textStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
            ),
            TextButton(
                onPressed: () {
                  print("Tapped Text Button");
                },
                child: Text("Text Button")),
            IconButton(
                onPressed: () {
                  print("Tapped Icon Button");
                },
                icon: Icon(Icons.person_2)),
            TextField(
              controller: searchTextFieldController,
              enabled: true,
              onTap: () {print("Textfield tapped");},
              keyboardType: TextInputType.emailAddress,
              onChanged: (String input) {
                print(input);
              },
              textInputAction: TextInputAction.done,
              onSubmitted: (String value) {
                print(searchTextFieldController.text);
                searchTextFieldController.clear();
              },
              obscureText: false,
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.remove_red_eye_outlined),
                hintText: "Enter your name",
                label: Text("Name"),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.amber,
                    width: 5,
                    style: BorderStyle.solid
                  )
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.red,
                        width: 5,
                        style: BorderStyle.solid
                    )
                ),
                disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.red,
                        width: 10,
                        style: BorderStyle.solid
                    )
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.red,
                        width: 5,
                        style: BorderStyle.solid
                    )
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                print("Tap detected!");
              },
              child: Container(
                //color: Colors.red,
                width: 500,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.amber,
                    width: 10,
                    style: BorderStyle.solid
                  ),
                  //shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 10,
                      offset: Offset(4,8),
                    ),
                    BoxShadow(
                      color: Colors.red,
                      blurRadius: 5,
                      offset: Offset(4,8),
                    )
                  ]
                ),
                alignment: Alignment.center,
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                child: Text("Container")
              ),
            ),
            InkWell(
              onTap: () {
                print("Inkwell detected");
              },
              splashColor: Colors.red,
              highlightColor: Colors.amber,
              radius: 100,
              child: Text("Inkwell"),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {print("Tapped Floating Button");},
        child: Icon(Icons.add),
      ),
    );
  }
}
