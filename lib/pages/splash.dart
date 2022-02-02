import 'package:flutter/material.dart';
import 'package:money_manager/controller/db_helper.dart';
import 'package:money_manager/pages/add_name.dart';
import 'package:money_manager/pages/home_page.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  //
  DbHelper dbHelper = DbHelper();
  //

  Future getSetting() async {
    String name = await dbHelper.getName();

    if (name.isNotEmpty) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => AddName(),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    getSetting();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
      ),
      //
      backgroundColor: Color(0xffe2e7ef),
      //
      body: Center(
        child: Container(
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
      ),
    );
  }
}
