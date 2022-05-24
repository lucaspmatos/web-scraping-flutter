import 'package:flutter/material.dart';
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;

import 'package:web_scraping_flutter/core/constants/strings.dart';
import 'package:web_scraping_flutter/core/components/components.dart';

class WebScrapingApp extends StatefulWidget {
  const WebScrapingApp({Key? key}) : super(key: key);

  @override
  _WebScrapingAppState createState() => _WebScrapingAppState();
}

class _WebScrapingAppState extends State<WebScrapingApp> {
// Strings to store the extracted article titles
  String firstResult = '1st result';
  String secondResult = '2st result';
  String thirdResult = '3st result';

// Boolean to show CircularProgressIndication while Web Scraping awaits
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          appTitle,
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isLoading
                ? const CircularProgressIndicator()
                : Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    margin: const EdgeInsets.all(20),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        ResultText(firstResult),
                        WidgetSpacer.vertical(5),
                        ResultText(secondResult),
                        WidgetSpacer.vertical(5),
                        ResultText(thirdResult),
                      ],
                    ),
                  ),
            WidgetSpacer.vertical(8),
            MainButton(
              onPressed: () => _pressButton(),
            ),
          ],
        ),
      ),
    );
  }

  void _pressButton() async {
    setState(() {
      isLoading = true;
    });

    final response = await _extractData();

    setState(() {
      firstResult = response[0];
      secondResult = response[1];
      thirdResult = response[2];
      isLoading = false;
    });
  }
}

Future<List<String>> _extractData() async {
  final response = await http.Client().get(
    Uri.parse(
      'https://www.geeksforgeeks.org/',
    ),
  );

  if (response.statusCode == 200) {
    var document = parser.parse(response.body);

    try {
      // Scraping the first article title
      var firstResponse = document
          .getElementsByClassName('articles-list')[0]
          .children[4]
          .children[0]
          .children[0];

      // Scraping the second article title
      var secondResponse = document
          .getElementsByClassName('articles-list')[0]
          .children[5]
          .children[0]
          .children[0];

      // Scraping the third article title
      var thirdResponse = document
          .getElementsByClassName('articles-list')[0]
          .children[6]
          .children[0]
          .children[0];

      return [
        firstResponse.text.trim(),
        secondResponse.text.trim(),
        thirdResponse.text.trim()
      ];
    } catch (e) {
      return ['', '', 'ERROR!'];
    }
  } else {
    return ['', '', 'ERROR: ${response.statusCode}.'];
  }
}
