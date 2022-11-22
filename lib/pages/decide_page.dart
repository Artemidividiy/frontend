import 'dart:developer';
import 'package:colorful/pages/decide_card.dart';
import 'package:colorful/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:swipe_cards/swipe_cards.dart';

class DecidePage extends StatefulWidget {
  const DecidePage({Key? key}) : super(key: key);

  @override
  State<DecidePage> createState() => _DecidePageState();
}

class _DecidePageState extends State<DecidePage> {
  late MatchEngine _matchEngine;
  List<SwipeItem>? _items;
  @override
  void initState() {
    _items = List.generate(
        3,
        (index) => SwipeItem(
            content: DecideCard(),
            likeAction: () => log("good👍"),
            nopeAction: () => log("nope🤮"),
            superlikeAction: null));
    _matchEngine = MatchEngine(swipeItems: _items);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          constraints: BoxConstraints.loose(Size(250, 450)),
          child: SwipeCards(
              matchEngine: _matchEngine,
              onStackFinished: () {
                log("finished");
                Navigator.of(context).pushReplacement(PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      HomePage(),
                ));
              },
              itemBuilder: (context, index) =>
                  Container(child: _items![index].content)),
        ),
      ),
    );
  }
}
