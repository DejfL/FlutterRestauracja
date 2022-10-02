import 'package:flutter/material.dart';
import 'package:restauracja/const.dart';
import 'package:restauracja/screens/homeScreen.dart';
import 'package:restauracja/screens/test.dart';

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
        toggleableActiveColor: greenColor,
        progressIndicatorTheme:
            const ProgressIndicatorThemeData().copyWith(color: greenColor),
        textTheme: const TextTheme().copyWith(
          headline3: const TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
          headline4: const TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          headline5: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
          headline6: const TextStyle(
            color: greenColor,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          caption: const TextStyle(
            color: greenColor,
            fontWeight: FontWeight.bold,
            fontSize: 15,
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
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: greenColor),
      ),
      home: const HomeScreen(),
    );
  }
}
