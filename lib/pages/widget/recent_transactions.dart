import 'package:flutter/material.dart';
import 'package:money_manager/bloc/transaction_bloc.dart';
import 'package:money_manager/controller/db_helper.dart';
import 'package:money_manager/modals/transaction_modal.dart';
import 'package:money_manager/pages/widget/confirm_dialog.dart';
import 'package:provider/src/provider.dart';

Widget getRecentTransaction(
    BuildContext context, DbHelper dbHelper, TransactionLoadedState state) {
  return Column(
    children: [
      Padding(
        padding: EdgeInsets.all(
          12.0,
        ),
        child: Text(
          "Recent Transactions",
          style: TextStyle(
            fontSize: 30.0,
            color: Colors.black87,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      //
      ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: state.data.length,
        itemBuilder: (context, index) {
          TransactionModel dataAtIndex = state.data[index];

          return _transactionTile(
            context,
            dbHelper,
            dataAtIndex.amount,
            dataAtIndex.description,
            dataAtIndex.date,
            dataAtIndex.type,
            index,
          );
        },
      )
    ],
  );
}

Widget _transactionTile(BuildContext context, DbHelper dbHelper, int amount,
    String description, DateTime date, String type, int index) {
  List<String> _months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec",
  ];

  return InkWell(
    onLongPress: () async {
      bool? answer = await showConfirmDialog(
        context,
        "WARNING",
        "Do you want to delete this record",
      );

      if (answer != null && answer == true) {
        dbHelper.deleteData(index);
        context.read<TransactionBloc>().add(LoadDataEvent());
      }
    },
    child: Container(
      margin: EdgeInsets.all(
        8.0,
      ),
      padding: EdgeInsets.all(
        24.0,
      ),
      decoration: BoxDecoration(
        color: Color(
          0xffced4eb,
        ),
        borderRadius: BorderRadius.circular(
          8.0,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(
                  6.0,
                ),
                child: Text(
                  "${date.day} - ${_months[date.month - 1]}",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
              ),
              //
              Row(
                children: [
                  Icon(
                    type == "Income"
                        ? Icons.arrow_circle_down_outlined
                        : Icons.arrow_circle_up_outlined,
                    size: 28.0,
                    color:
                        type == "Income" ? Colors.green[700] : Colors.red[700],
                  ),
                  //
                  SizedBox(
                    width: 12.0,
                  ),
                  //
                  Text(
                    description,
                    style:
                        TextStyle(fontSize: 25.0, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ],
          ),
          //
          Text(
            type == "Income" ? "+ $amount" : "- $amount",
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}
