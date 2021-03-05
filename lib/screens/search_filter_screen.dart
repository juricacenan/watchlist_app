import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_ui/components/movie_list.dart';
import 'package:movie_ui/helper/movie_helper.dart';
import 'package:movie_ui/models/movie.dart';
import 'package:movie_ui/screens/favorites_screen.dart';
import 'package:movie_ui/screens/movie_detail.dart';
import 'package:movie_ui/screens/movie_screen_home.dart';

class SearchFilterScreen extends StatefulWidget {
  @override
  _SearchFilterScreenState createState() => _SearchFilterScreenState();
}

class _SearchFilterScreenState extends State<SearchFilterScreen> {
  final searchTextController = new TextEditingController();
  final searchYearController = new TextEditingController();
  String searchText = "";
  String searchYear = "";
  String valueType;
  List listItem = ["movie", "series"];

  @override
  void dispose() {
    searchTextController.dispose();
    searchYearController.dispose();

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
      appBar: AppBar(
        backgroundColor: Colors.blue[200],
        title: Container(
          child: Text('Advanced search'),
        ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              child: Row(
                children: <Widget>[
                  Flexible(
                    child: TextField(
                      autofocus: false,
                      controller: searchTextController,
                      decoration: InputDecoration(
                        hintText: 'Enter a name',
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.search),
                    tooltip: 'Search Movies',
                    onPressed: () {
                      setState(() {
                        searchText = searchTextController.text;
                        searchYear = searchYearController.text;
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
                        searchYearController.clear();
                      });
                    },
                  ),
                ],
              ),
              padding: EdgeInsets.all(10),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              padding: EdgeInsets.only(left: 12, right: 20),
              child: DropdownButton(
                hint: Text('Type of result: '),
                icon: Icon(Icons.arrow_drop_down),
                iconSize: 36,
                isExpanded: true,
                value: valueType,
                onChanged: (newValue) {
                  setState(() {
                    valueType = newValue;
                  });
                },
                items: listItem.map((valueItem) {
                  return DropdownMenuItem(
                    value: valueItem,
                    child: Text(valueItem),
                  );
                }).toList(),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 12),
            child: Container(
              padding: EdgeInsets.only(left: 12.0, right: 20),
              child: Row(
                children: <Widget>[
                  Flexible(
                    child: TextField(
                      autofocus: false,
                      controller: searchYearController,
                      decoration: InputDecoration(
                        hintText: 'Enter a year',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (searchText.length > 0)
            FutureBuilder<List<Movie>>(
                future:
                    filterMovies(searchText, searchYear, valueType.toString()),
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
      ),
    );
  }
}
