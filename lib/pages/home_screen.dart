import 'package:flutter/material.dart';
import 'package:rig_works/tabs/home_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      // physics: NeverScrollableScrollPhysics(),
      children: [HomeTab()],
    );
  }
}
