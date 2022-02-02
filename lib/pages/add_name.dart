import 'package:flutter/material.dart';
import 'package:money_manager/controller/db_helper.dart';
import 'package:money_manager/pages/home_page.dart';

class AddName extends StatefulWidget {
  const AddName({Key? key}) : super(key: key);

  @override
  _AddNameState createState() => _AddNameState();
}

class _AddNameState extends State<AddName> {
  //
  DbHelper dbHelper = DbHelper();
  String name = "";
  //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
      ),
      //
      backgroundColor: Color(0xffe2e7ef),
      //
      body: Padding(
        padding: const EdgeInsets.all(
          12.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(
                16.0,
              ),
              decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.circular(
                  12.0,
                ),
              ),
              child: Image.asset(
                "assets/images/icon.png",
                width: 64.0,
                height: 64.0,
              ),
            ),
            //
            SizedBox(
              height: 12.0,
            ),
            //
            Text(
              "What should we call you ?",
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w900,
              ),
            ),
            //
            SizedBox(
              height: 12.0,
            ),
            //
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 16.0,
              ),
              decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.circular(
                  12.0,
                ),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Your Name",
                  border: InputBorder.none,
                ),
                style: TextStyle(
                  fontSize: 20.0,
                ),
                onChanged: (value) {
                  name = value;
                },
              ),
            ),
            //
            SizedBox(
              height: 12.0,
            ),
            //
            SizedBox(
              height: 50.0,
              width: double.maxFinite,
              child: ElevatedButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Next",
                      style: TextStyle(
                        fontSize: 25.0,
                      ),
                    ),
                    //
                    SizedBox(
                      width: 6.0,
                    ),
                    //
                    Icon(
                      Icons.navigate_next_rounded,
                    ),
                  ],
                ),
                onPressed: () {
                  // check name is not empty
                  if (name.isNotEmpty) {
                    // 1. add to SharedPreferences
                    dbHelper.addName(name);

                    // 2. navigate to home page
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ),
                    );
                  } else {
                    // show snak bar
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        action: SnackBarAction(
                          label: "OK",
                          onPressed: () {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          },
                        ),
                        backgroundColor: Colors.white,
                        content: Text(
                          "Please enter your name",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
