import 'package:show_demo/models/show.dart';
import 'package:show_demo/UI/show_details/details_header.dart';
import 'package:show_demo/UI/show_details/details_body.dart';
import 'package:show_demo/UI/show_details/details_footer.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class ShowDetailsPage extends StatefulWidget {
  final Show show;
  final Object showTag;

  ShowDetailsPage(
    this.show, {
      @required this.showTag
  });

  @override
  _ShowDetailsPageState createState() => new _ShowDetailsPageState();
}

class _ShowDetailsPageState extends State<ShowDetailsPage> {
  @override
  Widget build(BuildContext context) {
    var linearGradient = new BoxDecoration(
      gradient: new LinearGradient(
        begin: FractionalOffset.centerRight,
        end: FractionalOffset.bottomLeft,
        colors: [
          Colors.red,
          Colors.red
        ]
      )
    );

    return new Scaffold(
      body: new SingleChildScrollView(
        child: new Container(
          decoration: linearGradient,
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              new ShowDetailsHeader(
                widget.show,
                showTag: widget.showTag
              ),
              new Padding(
                padding: const EdgeInsets.all(24.0),
                child: new ShowDetailsBody(widget.show),
              ),
              new ShowFooter(widget.show),
            ],
          ),
        )
      )
    );
  }
}