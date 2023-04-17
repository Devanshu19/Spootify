import 'package:flutter/material.dart';
import 'package:spootify/screens/home.dart';
import 'package:spootify/screens/search.dart';
import 'package:spootify/screens/download.dart';

void main(){
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
        fontFamily: "Montserrat"
      ),
      home: HomePage(),
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
      appBar: AppBar(
        title: const Text("Spootify Music App"),
      ),
      body: tabs[currentTabIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (tappedItemIndex){
          currentTabIndex = tappedItemIndex;
          print(tappedItemIndex);
          setState(() {});
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home, color: Colors.white), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search, color: Colors.white), label: "Search"),
          BottomNavigationBarItem(icon: Icon(Icons.download, color: Colors.white), label: "Download"),
        ]
      ),
    );
  }
}