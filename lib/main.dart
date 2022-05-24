import 'package:flutter/material.dart';

import 'web_scraping_app.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.deepPurple[100],
        primaryColor: Colors.deepPurple,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Colors.deepPurple,
        ),
      ),
      home: const WebScrapingApp(),
    ),
  );
}
