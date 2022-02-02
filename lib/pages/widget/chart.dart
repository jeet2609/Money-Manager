import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:money_manager/static.dart' as Static;

Widget getChart(List<FlSpot> dataSet) {
  return Column(
    children: [
      Padding(
        padding: EdgeInsets.all(
          12.0,
        ),
        child: Text(
          "Expenses chart",
          style: TextStyle(
            fontSize: 32.0,
            color: Colors.black87,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      // chart
      dataSet.length < 2
          ? Container(
              margin: EdgeInsets.all(
                12.0,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 30.0,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(
                  8.0,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(
                      0.4,
                    ),
                    spreadRadius: 5,
                    blurRadius: 6,
                    offset: Offset(
                      0,
                      4,
                    ),
                  )
                ],
              ),
              child: SizedBox(
                width: double.maxFinite,
                child: Text(
                  "No enough data to render chart",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            )
          : Container(
              height: 350.0,
              margin: EdgeInsets.all(
                12.0,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 30.0,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(
                  8.0,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(
                      0.4,
                    ),
                    spreadRadius: 5,
                    blurRadius: 6,
                    offset: Offset(
                      0,
                      4,
                    ),
                  )
                ],
              ),
              child: LineChart(
                LineChartData(
                  borderData: FlBorderData(
                    show: false,
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      spots: dataSet,
                      isCurved: false,
                      barWidth: 3,
                      colors: [
                        Static.PrimaryColor,
                      ],
                    ),
                  ],
                ),
              ),
            ),
    ],
  );
}
