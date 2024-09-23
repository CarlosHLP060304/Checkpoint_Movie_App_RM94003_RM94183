import 'dart:convert';

class MovieDetails {
   String title;
   String posterPath;
   String overview;
   int runtime;
   List<Genre> genres;
   DateTime releaseDate;
   
    MovieDetails({
      required this.title,
      required this.genres,
      required this.overview,
      required this.posterPath,
      required this.releaseDate,
      required this.runtime
    });

   factory MovieDetails.fromJson(Map<String, dynamic> json) =>
      MovieDetails(
        overview: json["overview"] ?? '',
        genres: List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x))),
        posterPath: json["poster_path"] ?? '',
        releaseDate: DateTime.parse(json["release_date"]),
        runtime: json["runtime"],
        title: json["title"],
      );


}


class Genre {
  int id;
  String name;

  Genre({
    required this.id,
    required this.name,
  });

  factory Genre.fromRawJson(String str) => Genre.fromJson(json.decode(str));

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        id: json["id"] ?? 0,
        name: json["name"] ?? '',
      );
}
