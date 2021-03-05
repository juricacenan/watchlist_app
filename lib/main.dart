import 'package:flutter/material.dart';
import 'package:movie_ui/screens/favorites_screen.dart';
import 'package:movie_ui/screens/movie_screen_home.dart';
import 'package:movie_ui/screens/settings_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WatchlistApp',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    FavoritesScreen(),
    MoviesAppHome(),
    SettingsScreen(),
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[200],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'images/watchlist2.png',
              fit: BoxFit.contain,
              height: 32,
            ),
            Container(
                padding: const EdgeInsets.all(12.0),
                child: Text('WatchlistApp'))
          ],
        ),
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _currentIndex,
      backgroundColor: Colors.blue[200],
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white.withOpacity(.6),
      selectedFontSize: 14,
      unselectedFontSize: 14,
      onTap: onTabTapped,
      items: [
        BottomNavigationBarItem(
          title: Text('Favorites'),
          icon: Icon(Icons.favorite),
        ),
        BottomNavigationBarItem(
          title: Text('Search'),
          icon: Icon(Icons.search),
        ),
        BottomNavigationBarItem(
          title: Text('Settings'),
          icon: Icon(Icons.settings),
        ),
      ],
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
