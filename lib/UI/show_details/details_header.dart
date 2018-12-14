import 'package:show_demo/models/show.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:show_demo/services/api.dart';
import 'dart:async';

class ShowDetailsHeader extends StatefulWidget {
  final Show show;
  final Object showTag;

  ShowDetailsHeader(
    this.show, {
      @required this.showTag
  });

  @override
  _ShowDetailsHeaderState createState() => new _ShowDetailsHeaderState();
}

class _ShowDetailsHeaderState extends State<ShowDetailsHeader> {
  bool _likeDisabled = true;
  String _likeText = "";
  int _likeCount = 0;
  StreamSubscription _watcher;

  Future<ShowApi> _api;

  @override
  void initState() {
    super.initState();
    _likeCount = widget.show.likeCounter;
    _api = ShowApi.signInWithGoogle();
    updateLikeState();
  }

  void likeShow() async {
    final api = await _api;
    if(await api.likedShow(widget.show)) {
      api.unlikeShow(widget.show);
      setState(() {
        _likeCount -= 1;
        _likeText = "Like";        
      });
    } else {
      api.likeShow(widget.show);
      setState(() {
        _likeCount += 1;
        _likeText = "Unlike"; 
      });
    }
  }

  void updateLikeState() async {
    final api = await _api;
    _watcher = api.watch(widget.show, (show) {
      if(mounted) {
        setState(() {
          _likeCount = show.likeCounter;
        });
      }
    });

    bool liked = await api.likedShow(widget.show);
    if(mounted) {
        setState(() {
          _likeDisabled = false;
          _likeText = liked ? "Unlike":"Like";
        });
    }
  }

  @override
  void dispose() {
    if(_watcher != null) {
      _watcher.cancel();
    }
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;

    var image = new Hero(
      tag: widget.showTag,
      child: CircleAvatar(
        backgroundImage: new NetworkImage(widget.show.imageURL),
        radius: 75.0,
      ),
    );

    var likeInfo = new Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          new Icon(
            Icons.thumb_up,
            color: Colors.white,
            size: 16.0,
          ),
          new Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: new Text(
              _likeCount.toString(),
              style: textTheme.subhead.copyWith(color: Colors.white),
            )
          )
        ],
      ),
    );

    var actionButtons = new Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          new ClipRRect(
            borderRadius: new BorderRadius.circular(30.0),
            child: new RaisedButton(
              color: Colors.lightGreen,
              disabledColor: Colors.grey,
              textColor: Colors.white,
              onPressed: _likeDisabled? null : likeShow, 
              child: new Text(_likeText),
            ),
          )
        ],
      ),
    );

    return new Stack(
      children: [

        new Align(
          alignment: FractionalOffset.bottomCenter,
          heightFactor: 1.4,
          child: new Column(
            children: [
              image,
              likeInfo,
              actionButtons,
            ],
          )
        ),
        new Positioned(
          top: 26.0,
          left: 4.0,
          child: new BackButton(color: Colors.white),
        ),
      ],
    );
  }
}