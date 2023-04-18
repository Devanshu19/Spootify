import 'package:flutter/material.dart';
import 'package:spootify/screens/home.dart';
import 'package:spootify/screens/search.dart';
import 'package:spootify/screens/download.dart';

import 'package:spootify/helpers/spotify_helper.dart' as spotify_helper;
import 'package:spootify/config.dart' as config;

void main() async {

  config.spotifyAccessToken = await spotify_helper.getSpotifyAccessToken();

  runApp(const Spootify());
}

class Spootify extends StatelessWidget {
  const Spootify({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Spootify",
      darkTheme: ThemeData(
          primarySwatch: Colors.green,
          brightness: Brightness.dark,
          fontFamily: "MontserratBold"),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final tabs = [const Home(), const Search(), const Download()];

  int currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[currentTabIndex],
      bottomNavigationBar: SizedBox(
        height: 70,
        child: BottomNavigationBar(
          backgroundColor: Colors.black54,
          onTap: (tappedItemIndex) {
            currentTabIndex = tappedItemIndex;
            setState(() {});
          },
          currentIndex: currentTabIndex,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
            BottomNavigationBarItem(
                icon: Icon(Icons.download), label: "Download"),
          ],
          selectedIconTheme: const IconThemeData(size: 40),
          unselectedIconTheme: const IconThemeData(size: 30),
        ),
      ),
    );
  }
}
