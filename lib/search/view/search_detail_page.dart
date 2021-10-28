import 'package:flutter/material.dart';
import 'package:lastfm/data/track.dart';
import 'package:lastfm/l10n/l10n.dart';
import 'package:url_launcher/url_launcher.dart';

/// The page for showing detailed information of a given [track].
class SearchDetailPage extends StatelessWidget {
  const SearchDetailPage({required this.track, Key? key}) : super(key: key);

  /// The track to show the details from.
  final Track track;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.open_in_browser),
            onPressed: () => launch(Uri.parse(track.url).toString()),
          ),
        ],
        title: Text(l10n.appBarTitle),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        children: <Widget>[
          ListTile(
            title: Text(l10n.trackLabel),
            subtitle: Text(track.name),
          ),
          ListTile(
            title: Text(l10n.artistLabel),
            subtitle: Text(track.artist),
          ),
          ListTile(
            title: Text(l10n.listenersLabel),
            subtitle: Text(track.listeners),
          ),
        ],
      ),
    );
  }
}
