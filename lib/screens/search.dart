import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blueGrey.shade300,
                Colors.black45,
                Colors.black54
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight
            )
          ),
          child: Column(
            children: const [
              SearchAppBar(),
              SizedBox(height: 10),
              SearchBar(),
              SizedBox(height: 10),
              SearchButton()
            ]
          ),
        )
    );
  }
}

class SearchAppBar extends StatelessWidget {
  const SearchAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Padding(
        padding: const EdgeInsets.only(top:20),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: const Text(
            "Search", 
            style: TextStyle(
              fontFamily: "MontserratExtraBold",
              fontSize: 30
            )
          ),
        ),
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 16, right: 16),
      child: TextField(
        style: TextStyle(
          fontSize: 20,
          fontFamily: "MontserratBold"
        ),
        decoration: InputDecoration(
          hintText: "Enter Spotify Playlist link",
          hintStyle: TextStyle(
            fontSize: 16,
            fontFamily: "MontserratBold"
          )
        ),
      ),
    );
  }
}

class SearchButton extends StatefulWidget {
  const SearchButton({super.key});

  @override
  State<StatefulWidget> createState() => SearchButtonState();
}

class SearchButtonState extends State<SearchButton>{

  Color buttonColor = Colors.green;

  void onSearchButtonPressed(){

  }

  void searchButtonTapped(TapDownDetails details){
    Future.delayed(const Duration(milliseconds: 0));
    buttonColor = Colors.lightGreen;
    print("Tapped");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: searchButtonTapped,
      onTapCancel: () {
        Future.delayed(const Duration(milliseconds: 0));
        buttonColor = Colors.green;
        setState(() {});
        print("Tap Cancelled");
      },
      child: SizedBox(
        height: 40,
        width: 120,
        child: TextButton(
          onPressed: onSearchButtonPressed,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(buttonColor),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
            ))
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Padding(
                padding: EdgeInsets.only(right: 4),
                child: Icon(
                  Icons.search, 
                  color: Colors.white,
                  size: 20,
                )
              ),
              Text(
                "Search",
                style: TextStyle(
                  fontFamily: "MontserratBold",
                  fontSize: 20,
                  color: Colors.white
                ),
              )],
          ),
        ),
      ),
    );
  }
}