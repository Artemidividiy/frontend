import 'dart:developer';
import 'package:colorful/constants/EntryViewconstants.dart';
import 'package:colorful/core/entry/viewmodels/EntryViewModel.dart';
import 'package:colorful/core/entry/views/decide_card.dart';
import 'package:colorful/core/home/views/HomePage.dart';
import 'package:colorful/models/LocalUser.dart';
import 'package:flutter/material.dart';
import 'package:swipe_cards/swipe_cards.dart';

class DecidePage extends StatefulWidget {
  const DecidePage({Key? key}) : super(key: key);

  @override
  State<DecidePage> createState() => _DecidePageState();
}

class _DecidePageState extends State<DecidePage> {
  MatchEngine? _matchEngine;
  late EntryViewModel vm;
  List<SwipeItem>? _items;

  @override
  void initState() {
    vm = EntryViewModel();
    _items = List.generate(
        schemeCount,
        (index) => SwipeItem(
            content: DecideCard(
              index: index,
              vm: vm,
            ),
            likeAction: () => vm.swipeLeft(),
            nopeAction: () => vm.swipeRight(),
            superlikeAction: null));
    _matchEngine = MatchEngine(swipeItems: _items);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("logged in as ${LocalUser.instance!.email}")));
    });
    return Scaffold(
        body: Center(
      child: _matchEngine != null
          ? Container(
              constraints: BoxConstraints.loose(Size(250, 450)),
              child: SwipeCards(
                  matchEngine: _matchEngine ?? MatchEngine(),
                  onStackFinished: () {
                    log("finished");
                    Navigator.of(context).pushReplacement(PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          HomePage(),
                    ));
                  },
                  itemBuilder: (context, index) =>
                      Container(child: _items![index].content)),
            )
          : Container(
              alignment: Alignment.center,
              child: Text("Error"),
            ),
    ));
  }
}
