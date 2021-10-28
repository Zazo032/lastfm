import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lastfm/data/track.dart';
import 'package:lastfm/l10n/l10n.dart';
import 'package:lastfm/search/search.dart';

/// The parent of the search view, which provides the search cubit.
class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchCubit(),
      child: const SearchView(),
    );
  }
}

/// The view for the search page, with a text field for searching and a list
/// of the search results.
class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.appBarTitle),
        ),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    label: Text(l10n.inputFieldLabel),
                    suffixIcon: const Icon(Icons.search),
                  ),
                  onChanged: context.read<SearchCubit>().search,
                  textInputAction: TextInputAction.search,
                ),
              ),
            ),
            BlocBuilder<SearchCubit, TrackList?>(
              bloc: context.read<SearchCubit>(),
              builder: (BuildContext context, TrackList? tracks) {
                if (tracks == null || _searchController.text.isEmpty) {
                  return SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Text(l10n.searchPlaceholder),
                    ),
                  );
                } else {
                  if (tracks.isEmpty) {
                    return SliverFillRemaining(
                      child: Center(
                        child: Text(l10n.searchEmpty),
                      ),
                    );
                  } else {
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          final _track = tracks[index];
                          return ListTile(
                            title: Text(_track.name),
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) {
                                  return SearchDetailPage(track: _track);
                                },
                              ),
                            ),
                          );
                        },
                        childCount: tracks.length,
                      ),
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
