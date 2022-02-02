import 'package:flutter/material.dart';

import 'package:money_manager/static.dart' as Static;

Widget getBalanceCard(
    BuildContext context, int totalBalance, int totalIncome, int totalExpense) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.9,
    margin: EdgeInsets.all(
      12.0,
    ),
    child: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Static.PrimaryColor,
            Colors.blueAccent,
          ],
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(
            24.0,
          ),
        ),
      ),
      padding: EdgeInsets.symmetric(
        vertical: 20.0,
        horizontal: 8.0,
      ),
      child: Column(
        children: [
          Text(
            "Total Balance",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22.0,
              color: Colors.white,
            ),
          ),
          //
          SizedBox(
            height: 12.0,
          ),
          //
          Text(
            "Rs $totalBalance",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 26.0,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          //
          SizedBox(
            height: 12.0,
          ),
          //
          Padding(
            padding: EdgeInsets.all(
              8.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _cardTransaction(totalIncome.toString(), "Income"),
                //
                _cardTransaction(
                  totalExpense.toString(),
                  "Expense",
                ),
              ],
            ),
          ),
          //
        ],
      ),
    ),
  );
}

Widget _cardTransaction(String value, String type) {
  return Row(
    children: [
      Container(
        decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.circular(
            20.0,
          ),
        ),
        margin: EdgeInsets.only(
          right: 8.0,
        ),
        padding: EdgeInsets.all(
          6.0,
        ),
        child: Icon(
          type == "Income" ? Icons.arrow_downward : Icons.arrow_upward,
          size: 28.0,
          color: type == "Income" ? Colors.green[900] : Colors.red[900],
        ),
      ),
      //
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            type == "Income" ? "Income" : "Expense",
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.white70,
            ),
          ),
          //
          Text(
            value,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
              color: Colors.white70,
            ),
          ),
        ],
      )
    ],
  );
}
