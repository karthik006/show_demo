import 'package:meta/meta.dart';

class Show {
  final int showID;
  final String name;
  final String description;
  final String imageURL;
  final int likeCounter;
  final List<String> genre;
  final int episodes;
  final String imdbURL;

  Show({
    @required this.showID,
    @required this.name,
    @required this.description,
    @required this.imageURL,
    this.likeCounter = 0,
    @required this.genre,
    @required this.episodes,
    @required this.imdbURL,
  });

}