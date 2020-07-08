import 'package:movie/search.dart';

class Results{
  final int id;
  final String poster_path;
  final String original_title;
  final String overview;
  final String backdrop_path;
  final String release_date;


  Results({this.id, this.poster_path, this.original_title, this.overview,this.backdrop_path, this.release_date});

  factory Results.fromJson(Map<String, dynamic> json) {
    return Results(
      id: json['id'],
      poster_path: json['poster_path'] as String,
      original_title: json['original_title'] as String,
      overview: json['overview'] as String,
      backdrop_path: json['backdrop_path'] as String,
      release_date: json['release_date'] as String
    );
  }
}