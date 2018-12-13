import 'package:flutter/material.dart';
import 'package:show_demo/models/show.dart';
import 'package:show_demo/UI/show_details/details_page.dart';
import 'dart:async';

class ShowList extends StatefulWidget {
  @override
  _ShowListState createState() => new _ShowListState();
}

class _ShowListState extends State<ShowList> {
  
  List<Show> _shows = [];

  @override
  void initState() {
    super.initState();
    _loadShows();
  }

  _loadShows() async {

  }

  _navigateToShowDetails(Show show, Object showTag) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => ShowDetailsPage(show, showTag: showTag))
    );  
  }

  Widget _getAppTitleWidget() {
    return new Text(
      'Shows',
      style: new TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 32.0,
      ),
    );
  }

  Widget _buildShowItem(BuildContext context, int index) {
    Show shows = _shows[index];

    return new Container(
      margin: const EdgeInsets.only(top: 5.0),
      child: new Card(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new ListTile(
              onTap: () => _navigateToShowDetails(shows, index),
              leading: new Hero(
                tag:  index,
                child: new CircleAvatar(
                  backgroundImage: new NetworkImage(shows.imageURL),
                ),
              ),
              title: new Text(
                shows.name,
                style: new TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
              ),
              subtitle: new Text(shows.description),
              isThreeLine: true,
              dense: false,
            )
          ],
        ),
      ),
    );
  }

  Future<Null> refresh() {
    _loadShows();
    return new Future<Null>.value();
  }

  Widget _getListView() {
    return new Flexible(
      child: new RefreshIndicator(
        onRefresh: refresh,
        child: new ListView.builder(
          physics: AlwaysScrollableScrollPhysics(),
          itemCount: _shows.length,
          itemBuilder: _buildShowItem,
        ),
      )
    );
  }

  Widget _buildBody() {
    return new Container(
      margin: const EdgeInsets.fromLTRB(8.0, 56.0, 8.0, 0.0),
      child: new Column(
        children: <Widget>[
          _getAppTitleWidget(),
          _getListView(),
        ],
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.red,
      body: _buildBody(),
    );
  }
}