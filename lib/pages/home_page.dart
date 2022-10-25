import 'package:colorful/components/colorTile.dart';
import 'package:colorful/models/color.dart';
import 'package:colorful/utils/color_generator_local.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Widget> items;
  @override
  void initState() {
    ToneGenerator tg = ToneGenerator();
    items = List.generate(10, (index) {
      Color color = tg.generate(baseColor: Colors.black, distance: index * 0.1);
      return ColorTile(color: ColorModel(color: color, name: color.toString()));
    });
    super.initState();
  }

  Future<void> redraw() async {
    ToneGenerator tg = ToneGenerator();
    setState(() {
      items = List.generate(10, (index) {
        Color color =
            tg.generate(baseColor: Colors.indigo, distance: index * 0.1);
        return ColorTile(
            color: ColorModel(color: color, name: color.toString()));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
          child: ListView(
            children: items,
          ),
          onRefresh: redraw),
      // body:
    );
  }
}
