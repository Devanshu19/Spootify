import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:spootify/config.dart' as config;

Future<String> getSpotifyAccessToken() async {

  final bytes = utf8.encode("${config.spotifyClientId}:${config.spotifyClientSecret}");
  final base62Str = base64.encode(bytes);

  final response = await http.post(
    Uri.parse('https://accounts.spotify.com/api/token'),
    headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Basic $base62Str',
    },
    body: {
      'grant_type': 'client_credentials',
    },
  );

  final jsonData = jsonDecode(response.body);
  final accessToken = jsonData["access_token"];

  return accessToken;
}

Future<Map<String, dynamic>> getSpotifyPlaylistDetails(String playlistID) async {
  
  final uri = "${config.spotifyBase}/playlists/$playlistID";

  final response = await http.get(
    Uri.parse(uri),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${config.spotifyAccessToken}'
    }
  );

  return jsonDecode(response.body);
}