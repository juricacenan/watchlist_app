import 'package:flutter/material.dart';
import 'package:movie_ui/helper/movie_helper.dart';
import 'package:movie_ui/models/movie_info.dart';
import 'package:movie_ui/components/paddedtext.dart';

class MovieDetail extends StatelessWidget {
  final String movieName;
  final String imdbId;

  MovieDetail({this.movieName, this.imdbId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[200],
        title: Text('Title Details'),
      ),
      body: FutureBuilder<MovieInfo>(
          future: getMovie(this.imdbId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                          alignment: Alignment.center,
                          child: Image.network(
                            snapshot.data.poster,
                            width: 200,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('ADD TO FAVORITES'),
                            IconButton(
                              icon: Icon(Icons.favorite_border_outlined),
                              onPressed: () {},
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 20,
                          height: 20,
                        ),
                        EditedText(
                            "Title : " + snapshot.data.title.toUpperCase()),
                        EditedText("Release Date : " + snapshot.data.year),
                        EditedText(
                            "Type : " + snapshot.data.type.toUpperCase()),
                        SizedBox(
                          width: 20,
                          height: 20,
                        ),
                        EditedText(
                          'Plot : ' + snapshot.data.plot,
                        ),
                      ]));
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
