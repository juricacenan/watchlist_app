import 'package:flutter/material.dart';
import 'package:movie_ui/components/movie_item.dart';
import 'package:movie_ui/models/movie.dart';


class MovieList extends StatelessWidget {
  final List<Movie> movies;
  final Function itemClick;

  MovieList({this.movies, this.itemClick});

  @override
  Widget build(context) {
    return new Container(
         decoration: BoxDecoration(color: Colors.transparent),
        child: ListView.builder(
            
            padding: const EdgeInsets.all(8.0),
            itemCount: this.movies.length,
            itemBuilder: (BuildContext context, int index) {
              return new GestureDetector(
                  child: MovieItem(movie: this.movies[index]),
                  onTap: () => this.itemClick(this.movies[index]));
            }));
  }
}