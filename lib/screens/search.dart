import 'package:flutter/material.dart';
import 'package:spootify/helpers/music_objects.dart';
import 'package:spootify/helpers/spotify_helper.dart';
import 'package:spootify/helpers/youtube_helper.dart';

import 'package:spootify/config.dart' as config;

// Controller for playlist search bar textField
final TextEditingController _textEditingController = TextEditingController(text: "https://open.spotify.com/playlist/1TRRl6k0ixnAZtVGahDjSX?si=2b87a08d6acb4290");

final List<SpotifyTrack> trackObjects = [];
final List<Track> trackButtons = [];

// Main Search Tab of the application
class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<StatefulWidget> createState() => SearchState();
}

class SearchState extends State<Search>{

  late Function updateTracks = (){

    trackButtons.clear();

    for (SpotifyTrack trackObject in trackObjects) {
      trackButtons.add(Track(trackObject.trackName, trackObject.trackImageUrl, trackObject.artistName));
    }

    setState(() {});
  };

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
            children: [
              const SearchAppBar(),                   // Search heading
              const SizedBox(height: 10),
              const SearchBar(),                      // Search Bar
              const SizedBox(height: 10),
              SearchButton(updateTracks),             // Search Button
              const SizedBox(height: 10), 
              Expanded(                               // Track Display Area
                child: SizedBox(
                  height: 500,
                  child: SingleChildScrollView(       
                    child: Column(children: trackButtons),
                  ),
                ),
              )             
            ]
          ),
        )
    );
  }
}

// Main Search Bar including the search Text Field and Search Button
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

// The actual search Text Field
class SearchBar extends StatelessWidget {

  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: TextField(

        controller: _textEditingController,
        style: const TextStyle(
          fontSize: 20,
          fontFamily: "MontserratBold"
        ),
        decoration: const InputDecoration(
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

// The actual search button 
class SearchButton extends StatelessWidget {

  final Function updateTrackFunc;
  Color buttonColor = Colors.green;

  SearchButton(this.updateTrackFunc, {super.key});


  void onSearchButtonPressed() async {
    print("Searching for : ${_textEditingController.text}");

    final playlistID = _textEditingController.text.replaceFirst("${config.spotifyPlaylistBase}/", "").split("?")[0];

    final playlistDetails = await getSpotifyPlaylistDetails(playlistID);

    final tracks = playlistDetails["tracks"]["items"];

    trackObjects.clear();

    for (var track in tracks) {
      if(track["is_local"]) continue;

      SpotifyTrack newTrack = SpotifyTrack(track["track"]["name"], track["track"]["href"], track["track"]["album"]["images"][0]["url"], track["track"]["artists"][0]["name"]);
      trackObjects.add(newTrack);
    }

    updateTrackFunc();

    print(await downloadFromYoutube());

    print("Updated Tracks");
  }

  void searchButtonTapped(TapDownDetails details){
    Future.delayed(const Duration(milliseconds: 0));
    buttonColor = Colors.lightGreen;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: searchButtonTapped,
      onTapCancel: () {
        Future.delayed(const Duration(milliseconds: 0));
        buttonColor = Colors.green;
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

class Track extends StatelessWidget {

  final String trackName;
  final String trackArtist;
  final String trackImageUrl;

  final double trackHeight = 70; 

  final int maxCharactersInTitle = 40;

  Track(this.trackName, this.trackImageUrl, this.trackArtist);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom:5, left:5, right:5),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black38,
            borderRadius: BorderRadius.circular(10)
          ),
          child: Row(
            children: [
              SizedBox(                                       // Cover Image
                width: trackHeight,
                height: trackHeight,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(trackImageUrl)
                )
              ),
              Expanded(
                child: Padding(                                        // Name and artist
                  padding: const EdgeInsets.only(left: 10),
                  child: SizedBox(
                    height: trackHeight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            trackName.length > maxCharactersInTitle ? trackName.replaceRange(maxCharactersInTitle, trackName.length - 1, "...") : trackName, 
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              fontFamily: "MontserratBold",
                              fontSize: 15
                            )),
                        ),
                        Text(
                          trackArtist.length > maxCharactersInTitle ? trackArtist.replaceRange(maxCharactersInTitle, trackArtist.length - 1, "...") : trackArtist, 
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w200
                          )
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: trackHeight,
                child: IconButton(
                  onPressed: (){},
                  icon: const Icon(Icons.file_download_outlined)
                ),
              )
            ]
          ),
        ),
    );
  }
}