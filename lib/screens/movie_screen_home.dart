import 'package:flutter/material.dart';
import 'package:movie_ui/components/movie_list.dart';
import 'package:movie_ui/helper/movie_helper.dart';
import 'package:movie_ui/models/movie.dart';
import 'package:movie_ui/screens/movie_detail.dart';

import 'package:flutter/services.dart';
import 'package:movie_ui/screens/search_filter_screen.dart';

class MoviesAppHome extends StatefulWidget {
  @override
  MoviesAppHomeState createState() => MoviesAppHomeState();
}

class MoviesAppHomeState extends State<MoviesAppHome> {
  final searchTextController = new TextEditingController();
  String searchText = "";

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  void itemClick(Movie item) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => MovieDetail(
                movieName: item.title,
                imdbId: item.imdbID,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        Container(
          child: Row(children: <Widget>[
            Flexible(
              child: TextField(
                controller: searchTextController,
                decoration: InputDecoration(
                  hintText: 'Enter a movie/show name',
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.search),
              tooltip: 'Search Movies',
              onPressed: () {
                setState(() {
                  searchText = searchTextController.text;
                  SystemChannels.textInput.invokeMethod('TextInput.hide');
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.clear),
              tooltip: 'Clear Movies',
              onPressed: () {
                setState(() {
                  searchTextController.clear();
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.filter_list),
              tooltip: 'Filter Movies',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchFilterScreen(),
                    ));
              },
            ),
          ]),
          padding: EdgeInsets.all(10),
        ),
        if (searchText.length > 0)
          FutureBuilder<List<Movie>>(
              future: searchMovies(searchText),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                      child: MovieList(
                          movies: snapshot.data, itemClick: this.itemClick));
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return CircularProgressIndicator();
              }),
      ],
    ));
  }
}
