typedef TrackList = List<Track>;

extension TrackListParser on TrackList {
  static TrackList fromJson(Map<String, dynamic> json) {
    final _trackResults = <Track>[];
    final _results = json['results'] as Map<String, dynamic>;
    final _trackMatches = _results['trackmatches'] as Map<String, dynamic>;
    final _tracks =
        (_trackMatches['track'] as List<dynamic>).cast<Map<String, dynamic>>();
    for (final _track in _tracks) {
      _trackResults.add(Track.fromJson(_track));
    }

    return _trackResults;
  }
}

class Track {
  const Track({
    required this.artist,
    required this.listeners,
    required this.name,
    required this.url,
  });

  factory Track.fromJson(dynamic json) {
    json as Map<String, dynamic>;
    return Track(
      artist: json['artist'] as String,
      listeners: json['listeners'] as String,
      name: json['name'] as String,
      url: json['url'] as String,
    );
  }

  final String artist;
  final String listeners;
  final String name;
  final String url;
}
