import 'package:show_demo/models/show.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutShowCase extends StatelessWidget {
  final Show show;

  AboutShowCase(this.show);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return new Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: new Column(
        children: [
          new Text(
            "Number of episodes: " + show.episodes.toString(),
            style: textTheme.subhead.copyWith(color: Colors.white),
            textAlign: TextAlign.left,
          ),
          new Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: new InkWell(
              child: new Text(
                "Visit IMDB page ",
                style: textTheme.subhead.copyWith(color: Colors.white),
                textAlign: TextAlign.left,
              ),
              onTap: () => launch(show.imdbURL),
            )
          )
        ],
      ),
    );
  }  
}