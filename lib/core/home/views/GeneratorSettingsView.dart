import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:colorful/core/home/viewmodels/HomeViewModel.dart';

import '../../../enums/algo.dart';
import '../../../models/color.dart';

class MBSWidget {
  final HomeViewModel vm;

  MBSWidget(
    this.vm,
  );

  Widget showMBS(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            AlgoPicker(
              vm: vm,
            ),
          ],
        ),
      ),
    );
  }
}

class AlgoPicker extends StatefulWidget {
  final HomeViewModel vm;

  AlgoPicker({
    Key? key,
    required this.vm,
  }) : super(key: key);

  @override
  State<AlgoPicker> createState() => _AlgoPickerState();
}

class _AlgoPickerState extends State<AlgoPicker> {
  @override
  Widget build(BuildContext context) {
    HomeViewModel vm = widget.vm;
    return ConstrainedBox(
      constraints: BoxConstraints.loose(Size(Size.infinite.width, 100)),
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: [
          FilterChip(
              label: const Text("monochrome"),
              selected: ALGO.monochrome == vm.algo ? true : false,
              onSelected: (value) {
                setState(() {
                  vm.algo = ALGO.monochrome;
                  vm.currentScheme = vm.fetch();
                });
              }),
          FilterChip(
              label: const Text("analogic"),
              selected: ALGO.analogic == vm.algo ? true : false,
              onSelected: (value) {
                setState(() {
                  vm.algo = ALGO.analogic;
                  vm.currentScheme = vm.fetch();

                  print(vm.toString());
                });
              }),
          FilterChip(
              label: const Text("complement"),
              selected: ALGO.complement == vm.algo ? true : false,
              onSelected: (value) {
                setState(() {
                  vm.algo = ALGO.complement;
                  vm.currentScheme = vm.fetch();
                });
              }),
          FilterChip(
              label: const Text("analogic-complement"),
              selected: ALGO.analogicComplement == vm.algo ? true : false,
              onSelected: (value) {
                setState(() {
                  vm.algo = ALGO.analogicComplement;
                  vm.currentScheme = vm.fetch();
                });
              }),
          FilterChip(
              label: const Text("triad"),
              selected: ALGO.triad == vm.algo ? true : false,
              onSelected: (value) {
                setState(() {
                  vm.algo = ALGO.triad;
                  vm.currentScheme = vm.fetch();
                });
              }),
          FilterChip(
              label: const Text("quad"),
              selected: ALGO.quad == vm.algo ? true : false,
              onSelected: (value) {
                setState(() {
                  vm.algo = ALGO.quad;
                  vm.currentScheme = vm.fetch();
                });
              }),
        ],
      ),
    );
  }
}
