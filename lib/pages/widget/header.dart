import 'package:flutter/material.dart';

import 'package:money_manager/static.dart' as Static;

Widget getHeader(String name) {
  
  return Padding(
    padding: EdgeInsets.all(12.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SizedBox(
              width: 8.0,
            ),
            //
            Text(
              "Welcome $name",
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w700,
                color: Static.PrimaryMaterialColor[800],
              ),
            ),
          ],
        ),
        //
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              12.0,
            ),
            color: Colors.white70,
          ),
          padding: EdgeInsets.all(
            12.0,
          ),
          child: Icon(
            Icons.settings,
            size: 30.0,
            color: Color(
              0xff3E454C,
            ),
          ),
        ),
      ],
    ),
  );
  
}
