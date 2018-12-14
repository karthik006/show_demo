import 'package:show_demo/models/show.dart';
import 'package:flutter/material.dart';

class ShowDetailsBody extends StatelessWidget {
  final Show show;

  ShowDetailsBody(this.show);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;

    var genreInfo = new Row(
      children: [
        new Icon(
          Icons.movie,
          color: Colors.white,
          size: 16.0,
        ),
        new Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: new Text(
            show.genre.toString(),
            style: textTheme.subhead.copyWith(color: Colors.white),
          ),
        )
      ],
    );

    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        new Text(
          show.name,
          style: textTheme.headline.copyWith(color: Colors.white),
        ),
        new Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: genreInfo,
        ),
        new Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: new Text(
            show.description,
            style: textTheme.body1.copyWith(color: Colors.white70, fontSize: 16.0),
          ),
        ),
        new Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: new Row(
            children: [
              new CircleAvatar(
                backgroundColor: theme.accentColor,
                child: new Icon(
                  Icons.share,
                  color: Colors.red,
                  size: 16.0,
                ),
                radius: 16.0,
              )
            ],
          ),
        )
      ],
    );
  }
}