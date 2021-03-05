import 'package:flutter/material.dart';
import 'package:movie_ui/models/movie.dart' as models;

class MovieItem extends StatefulWidget {
  final models.Movie movie;

  MovieItem({this.movie});

  @override
  _MovieItemState createState() => _MovieItemState();
}

class _MovieItemState extends State<MovieItem> {
  Icon _iconFavorite = Icon(Icons.favorite_border);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Column(children: <Widget>[
            if (this.widget.movie.poster != "N/A")
              Image.network(this.widget.movie.poster, height: 150, width: 150)
          ]),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  this.widget.movie.title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 20,
                  height: 20,
                ),
                Text(this.widget.movie.type.toUpperCase()),
                SizedBox(
                  width: 20,
                  height: 20,
                ),
                Text(this.widget.movie.year),
                Row(
                  children: <Widget>[
                    Text('Add to favorites'),
                    IconButton(
                      icon: _iconFavorite,
                      onPressed: () {
                        setState(() {
                          _iconFavorite = Icon(Icons.favorite);
                          
                        });
                      },
                    ),
                  ],
                ),
                // IconButton(
                //   icon: Icon(Icons.favorite_border),
                //   onPressed: () {
                //     Icon(Icons.favorite);
                //   },
                // ),
              ],
            ),
          ),
        ],
      ),
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(top: 8, left: 10, right: 10),
      decoration: new BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: Colors.white),
    );
  }
}
