import 'package:flutter/material.dart';
import 'package:restauracja/const.dart';

SnackBar mySnackBar(String text) {
  return SnackBar(
    backgroundColor: primaryColor,
    behavior: SnackBarBehavior.floating,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
    ),
    margin: const EdgeInsets.only(left: 16, right: 16, bottom: 60),
    duration: const Duration(seconds: 2),
    content: Text(text),
  );
}
