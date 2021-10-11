import 'package:flutter/material.dart';

import 'homescreen.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      theme: ThemeData(
        primarySwatch: Colors.grey,
        appBarTheme: AppBarTheme(
          brightness: Brightness.dark,
        ),
      ),
    ),
  );
}
