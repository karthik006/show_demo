import 'package:show_demo/models/show.dart';
import 'package:flutter/material.dart';

class CommentsShowCase extends StatelessWidget {
  final Show show;

  CommentsShowCase(this.show);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return new Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: new Text(
        "Comments: ",
        style: textTheme.subhead.copyWith(color: Colors.white),
        textAlign: TextAlign.left,
      ),
    );
  }  
}