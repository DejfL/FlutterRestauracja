import 'package:flutter/material.dart';
import 'package:restauracja/const.dart';
import 'package:restauracja/screens/homeScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurancja',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ).copyWith(
        canvasColor: greyColor,
        scaffoldBackgroundColor: greyColor,
        progressIndicatorTheme:
            const ProgressIndicatorThemeData().copyWith(color: greenColor),
        textTheme: const TextTheme().copyWith(
          headline3: const TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
          headline5: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          caption: const TextStyle(
            color: greenColor,
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          hintStyle: TextStyle(
            color: primaryColor.withOpacity(0.5),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
