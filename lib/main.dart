import 'package:colorful/core/entry/views/decide_card.dart';
import 'package:flutter/material.dart';
  
import 'core/entry/views/decide_page.dart';
import 'core/home/views/HomePage.dart';

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
