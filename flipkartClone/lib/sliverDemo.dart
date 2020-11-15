import 'package:flutter/material.dart';

class SliverDemo extends StatefulWidget {
  @override
  _SliverDemoState createState() => _SliverDemoState();
}

class _SliverDemoState extends State<SliverDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: CustomScrollView(
        slivers: [
          SliverAppBar(
            //floating: true,//this means the app bar will be expanded and shrinked according to the scrolls
            pinned: true,//with this property the appbar will remain fixed
            expandedHeight: 400,//to give a min height
            flexibleSpace: FlexibleSpaceBar(),
          )
        ],
      )),
    );
  }
}
