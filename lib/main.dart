import 'package:colorful/pages/decide_card.dart';
import 'package:flutter/material.dart';

import 'pages/decide_page.dart';
import 'pages/home_page.dart';

void main(List<String> args) {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const Colorful());
}

class Colorful extends StatelessWidget {
  const Colorful({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DecidePage(),
    );
  }
}
