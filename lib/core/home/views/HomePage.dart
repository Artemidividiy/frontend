import 'package:colorful/core/components/expandable_tile.dart';
import 'package:colorful/core/home/viewmodels/HomeViewModel.dart';
import 'package:colorful/models/color.dart';
import 'package:colorful/utilities/color_generator_local.dart';
import 'package:flutter/material.dart';

import '../../../enums/algo.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeViewModel vm = HomeViewModel();
  late Future<List<ColorModel>?> currentScheme;
  late List<bool> isOpened;
  ALGO algo = ALGO.monochrome;
  _normalizeColor(ColorModel color) {
    return "${color.color.red} ${color.color.green} ${color.color.blue}";
  }

  @override
  void initState() {
    isOpened = List.generate(5, (index) => false);
    super.initState();
    currentScheme = vm.currentScheme;
  }

  @override
  Widget build(BuildContext context) {
    algo = vm.algo;
    return Scaffold(
      floatingActionButton: IconButton(
        icon: const Icon(Icons.add),
        onPressed: () => setState(() {
          vm.currentScheme = vm.fetch();
          currentScheme = vm.currentScheme;
        }),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            ConstrainedBox(
              constraints: BoxConstraints.loose(Size(Size.infinite.width, 100)),
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: [
                  FilterChip(
                      label: const Text("monochrome"),
                      selected: ALGO.monochrome == algo ? true : false,
                      onSelected: (value) {
                        setState(() {
                          vm.algo = ALGO.monochrome;
                          currentScheme = vm.fetch();
                        });
                      }),
                  FilterChip(
                      label: const Text("analogic"),
                      selected: ALGO.analogic == algo ? true : false,
                      onSelected: (value) {
                        setState(() {
                          vm.algo = ALGO.analogic;
                          currentScheme = vm.fetch();
                        });
                      }),
                  FilterChip(
                      label: const Text("complement"),
                      selected: ALGO.complement == algo ? true : false,
                      onSelected: (value) {
                        setState(() {
                          vm.algo = ALGO.complement;
                          currentScheme = vm.fetch();
                        });
                      }),
                  FilterChip(
                      label: const Text("analogic-complement"),
                      selected: ALGO.analogicComplement == algo ? true : false,
                      onSelected: (value) {
                        setState(() {
                          vm.algo = ALGO.analogicComplement;
                          currentScheme = vm.fetch();
                        });
                      }),
                  FilterChip(
                      label: const Text("triad"),
                      selected: ALGO.triad == algo ? true : false,
                      onSelected: (value) {
                        setState(() {
                          vm.algo = ALGO.triad;
                          currentScheme = vm.fetch();
                        });
                      }),
                  FilterChip(
                      label: const Text("quad"),
                      selected: ALGO.quad == algo ? true : false,
                      onSelected: (value) {
                        setState(() {
                          vm.algo = ALGO.quad;
                        });
                      }),
                ],
              ),
            ),
            FutureBuilder<List<ColorModel>?>(
                future: currentScheme,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: List.generate(5, (index) {
                        return Designed(ExpandableTile(
                          header: null,
                          body: null,
                        )).widget(snapshot: snapshot, index: index);
                      }),
                    );
                  }
                  return const Center(child: const CircularProgressIndicator());
                })
          ]),
        ),
      ),
    );
  }
}
