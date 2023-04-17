import 'package:flutter/material.dart';

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
      home: HomePage()
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Spootify Music App"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home, color: Colors.white), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search, color: Colors.white), label: "Search"),
          BottomNavigationBarItem(icon: Icon(Icons.download, color: Colors.white), label: "Download"),
        ]
      ),
    );
  }
}