import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:speach_app/shared/components/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Speech App'),
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(
                text: "Speech to Text",
                icon: Icon(Icons.mic_none),
              ),
              Tab(
                text: "Text to Speech",
                icon: Icon(Icons.text_format_rounded),
              ),
            ],
          ),
        ),
        body: TabBarView(
          dragStartBehavior: DragStartBehavior.start,
          controller: _tabController,
          children: screens,
        ));
  }
}
