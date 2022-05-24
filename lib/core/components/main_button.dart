import 'package:flutter/material.dart';

import 'package:web_scraping_flutter/core/constants/strings.dart';

class MainButton extends StatelessWidget {
  const MainButton({Key? key, required this.onPressed}) : super(key: key);

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      child: const Text(
        buttonText,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      color: Colors.deepPurple,
    );
  }
}
