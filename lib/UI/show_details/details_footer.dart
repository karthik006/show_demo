import 'package:show_demo/models/show.dart';
import 'package:show_demo/UI/show_details/showcase_about.dart';
import 'package:show_demo/UI/show_details/showcase_comments.dart';
import 'package:flutter/material.dart';

class ShowFooter extends StatefulWidget {
  final Show show;

  ShowFooter(this.show);

  @override
  _ShowFooterState createState() => new _ShowFooterState();
}

class _ShowFooterState extends State<ShowFooter> with TickerProviderStateMixin{

  List<Tab> _tabs;
  List<Widget> _pages;
  TabController _controller;

  @override
  void initState() {
      super.initState();
      _tabs = [
        new Tab(text: 'About'),
        new Tab(text: 'Comments')
      ];
      _pages = [
        new AboutShowCase(widget.show),
        new CommentsShowCase(widget.show),
      ];
      _controller = new TabController(
        length: _tabs.length,
        vsync: this,
      );
    }

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.all(16.0),
      child: new Column(
        children: [
          new TabBar(
            controller: _controller,
            tabs: _tabs,
            indicatorColor: Colors.white,
          ),
          new SizedBox.fromSize(
            size: const Size.fromHeight(300.0),
            child: new TabBarView(
              controller: _controller,
              children: _pages,
            ),
          )
        ],
      ),
    );
  }
}