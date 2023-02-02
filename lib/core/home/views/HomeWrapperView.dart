import 'package:colorful/core/user/views/UserView.dart';
import 'package:flutter/material.dart';

import 'HomeView.dart';

class HomeWrapperView extends StatefulWidget {
  const HomeWrapperView({super.key});

  @override
  State<HomeWrapperView> createState() => _HomeWrapperViewState();
}

class _HomeWrapperViewState extends State<HomeWrapperView> {
  @override
  Widget build(BuildContext context) {
    return PageView(
      children: [HomeView(), UserView()],
    );
  }
}
