import 'package:dio/dio.dart';
import 'package:lastfm/data/track.dart';

class LastApi {
  const LastApi._();

  static const kApiUrl = 'http://ws.audioscrobbler.com';
  static const _apiKey = '704f066571079cda9edebc22efa3e9ab';

  static Future<TrackList> searchTracks(String query) async {
    final _url =
        '$kApiUrl/2.0/?method=track.search&format=json&api_key=$_apiKey&track=$query';
    final _response = await Dio().get<Map<String, dynamic>>(_url);
    if (_response.statusCode == 200 && _response.data != null) {
      return TrackListParser.fromJson(_response.data!);
    } else {
      return [];
    }
  }
}
