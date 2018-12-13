import 'package:show_demo/models/show.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

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
              widget.show.likeCounter.toString(),
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
              onPressed: () async {

              },
              child: new Text('LIKE'),
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