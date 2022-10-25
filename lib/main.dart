import 'package:flutter/material.dart';

import 'pages/home_page.dart';

void main(List<String> args) {
  runApp(const Colorful());
}

class Colorful extends StatelessWidget {
  const Colorful({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}
