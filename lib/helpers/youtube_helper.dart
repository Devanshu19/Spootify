import 'dart:io';

import 'package:youtube_explode_dart/youtube_explode_dart.dart' as ytExplode;

Future<bool> downloadFromYoutube() async {
  
  var client = ytExplode.YoutubeHttpClient();
  var searchClient = ytExplode.SearchClient(client);

  ytExplode.VideoSearchList videos = await searchClient.search("mephisto queen bee");

  String videoID = videos.first.url.replaceAll("https://www.youtube.com/watch?v=", "");

  var downloader = ytExplode.YoutubeExplode();

  ytExplode.StreamManifest streamManifest = await downloader.videos.streamsClient.getManifest(videoID);

  ytExplode.AudioOnlyStreamInfo streamInfo = streamManifest.audioOnly.withHighestBitrate();

  if(streamInfo == null) return false;

  var stream = downloader.videos.streamsClient.get(streamInfo);

  return true;
}