import 'package:colorful/core/components/expandable_tile.dart';
import 'package:colorful/core/home/viewmodels/HomeViewModel.dart';
import 'package:colorful/core/home/views/ExportSchemeView.dart';

import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../../../models/ColorScheme.dart' as cs;
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

import '../../../enums/algo.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeViewModel vm = HomeViewModel();
  late Future<List<cs.ColorScheme>?> currentScheme;
  late List<bool> isOpened;
  bool liked = false;
  ALGO algo = ALGO.monochrome;
  late ValueNotifier<Future<List<cs.ColorScheme>?>> notifier =
      ValueNotifier<Future<List<cs.ColorScheme>?>>(vm.fetch());
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
        icon: const Icon(Icons.settings),
        onPressed: () => showModalBottomSheet(
          context: context,
          builder: (context) {
            return StatefulBuilder(
              builder: (context, setState) => SingleChildScrollView(
                child: Column(
                  children: [
                    ConstrainedBox(
                      constraints:
                          BoxConstraints.loose(Size(Size.infinite.width, 100)),
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
                                  algo = ALGO.monochrome;
                                  currentScheme = vm.fetch();
                                  liked = false;
                                });
                                notifier.value = currentScheme;
                              }),
                          FilterChip(
                              label: const Text("analogic"),
                              selected: ALGO.analogic == algo ? true : false,
                              onSelected: (value) {
                                setState(() {
                                  vm.algo = ALGO.analogic;
                                  algo = ALGO.analogic;
                                  currentScheme = vm.fetch();
                                  liked = false;
                                });
                                notifier.value = currentScheme;
                              }),
                          FilterChip(
                              label: const Text("complement"),
                              selected: ALGO.complement == algo ? true : false,
                              onSelected: (value) {
                                setState(() {
                                  vm.algo = ALGO.complement;
                                  algo = ALGO.complement;
                                  currentScheme = vm.fetch();
                                  liked = false;
                                });
                                notifier.value = currentScheme;
                              }),
                          FilterChip(
                              label: const Text("analogic-complement"),
                              selected: ALGO.analogicComplement == algo
                                  ? true
                                  : false,
                              onSelected: (value) {
                                setState(() {
                                  vm.algo = ALGO.analogicComplement;
                                  algo = ALGO.analogicComplement;
                                  currentScheme = vm.fetch();
                                  liked = false;
                                });
                                notifier.value = currentScheme;
                              }),
                          FilterChip(
                              label: const Text("triad"),
                              selected: ALGO.triad == algo ? true : false,
                              onSelected: (value) {
                                setState(() {
                                  vm.algo = ALGO.triad;
                                  algo = ALGO.triad;
                                  currentScheme = vm.fetch();
                                  liked = false;
                                });
                                notifier.value = currentScheme;
                              }),
                          FilterChip(
                              label: const Text("quad"),
                              selected: ALGO.quad == algo ? true : false,
                              onSelected: (value) {
                                setState(() {
                                  vm.algo = ALGO.quad;
                                  algo = ALGO.quad;
                                  liked = false;
                                  currentScheme = vm.fetch();
                                });
                              }),
                        ],
                      ),
                    ),
                    Text("Colors:"),
                    NumberPicker(
                        axis: Axis.horizontal,
                        minValue: 5,
                        maxValue: 10,
                        value: vm.colorsCount,
                        onChanged: (value) async {
                          setState(() {
                            vm.colorsCount = value;
                            liked = false;
                          });
                          vm.fetch().then((value) {
                            currentScheme = Future.value(value);
                          }).then((_) => notifier.value = currentScheme);
                        }),
                    Padding(padding: EdgeInsets.only(bottom: 20))
                  ],
                ),
              ),
            );
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            ValueListenableBuilder<Future<List<cs.ColorScheme>?>>(
                valueListenable: notifier,
                builder: (context, value, child) =>
                    FutureBuilder<List<cs.ColorScheme>?>(
                        future: currentScheme,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Column(
                              children: List.generate(vm.colorsCount, (index) {
                                return Designed(ExpandableTile(
                                  header: null,
                                  body: null,
                                )).widget(
                                    onChangedMethod: (n) => setState(() =>
                                        snapshot.data!.first.colors[index]
                                            .color = n),
                                    context: context,
                                    snapshot: snapshot,
                                    index: index);
                              }),
                            );
                          }
                          return const Center(
                              child: const CircularProgressIndicator());
                        })),
            IconButton(
                onPressed: () async {
                  if (liked) {
                    setState(() {
                      liked = false;
                    });
                    await vm.dislikeScheme();
                  } else {
                    setState(() {
                      liked = true;
                    });
                    await vm.likeScheme();
                  }
                },
                icon: AnimatedContainer(
                  duration: Duration(milliseconds: 125),
                  child: liked
                      ? Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )
                      : Icon(
                          Icons.favorite_border,
                          color: Colors.grey,
                        ),
                )),
            TextButton(
                onPressed: () => showModalBottomSheet(
                      context: context,
                      builder: (context) => ExportSchemeView(vm: vm),
                    ),
                child: Text("Export")),
            TextButton(
                onPressed: () => showModalBottomSheet(
                      context: context,
                      builder: (context) => QRView(
                        key: GlobalKey(),
                        onQRViewCreated: (p0) {
                          vm.qrViewController = p0;
                          vm.qrViewController?.scannedDataStream.listen((data) {
                            setState(() {
                              currentScheme = Future.value([
                                vm.importFromQrCode(context, data.code ?? "")
                              ]);
                            });
                          });
                        },
                      ),
                    ),
                child: Text("Import")),
          ]),
        ),
      ),
    );
  }
}
