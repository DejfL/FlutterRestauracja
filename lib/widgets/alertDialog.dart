import 'package:flutter/material.dart';
import 'package:restauracja/const.dart';

Future<void> okDialog(BuildContext context, String text) async {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: const EdgeInsets.all(10),
        insetPadding: const EdgeInsets.all(10),
        title: Column(
          children: [
            const Icon(
              Icons.feedback,
              color: greenColor,
              size: 60,
            ),
            Text(
              'Uwaga',
              style: Theme.of(context).textTheme.headline3,
            ),
          ],
        ),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: primaryColor,
                ),
              ),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}
