import 'dart:convert';

import 'dates_model.dart';
import 'movie_model.dart';

class Movies {
  int? page;
  List<Movie>? movies;
  Dates? dates;
  int? totalPages;
  int? totalResults;

  Movies({
    this.page,
    this.movies,
    this.dates,
    this.totalPages,
    this.totalResults,
  });

  Movies.fromMap(Map<String, dynamic> json) {
    page = json['page'];
    if (json['results'] != null) {
      movies = <Movie>[];
      json['results'].forEach((v) {
        movies!.add(Movie.fromJson(v));
      });
    }
    dates = json['dates'] != null ? Dates.fromJson(json['dates']) : null;
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    if (movies != null) {
      data['results'] = movies!.map((v) => v.toJson()).toList();
    }
    if (dates != null) {
      data['dates'] = dates!.toJson();
    }
    data['total_pages'] = totalPages;
    data['total_results'] = totalResults;
    return data;
  }
  String toJson() => json.encode(toMap());

  factory Movies.fromJson(String source) => Movies.fromMap(json.decode(source));
}
