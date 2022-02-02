import 'package:flutter/material.dart';

showConfirmDialog(BuildContext context, String title, String content) async {
  return await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        ElevatedButton(
          child: Text(
            "Yes",
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              Colors.red,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
        ElevatedButton(
          child: Text(
            "No",
          ),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
      ],
    ),
  );
}
