import 'package:bloc/bloc.dart';
import 'package:lastfm/api/api.dart';
import 'package:lastfm/data/track.dart';

// This Cubit could be converted to a Bloc to add Error and Loading states.
// Also, by converting the Cubit to a Bloc, we could set a transformer from
// the bloc_concurrency package to be "restartable" (process only the latest
// event and cancel previous event handlers).
class SearchCubit extends Cubit<TrackList?> {
  SearchCubit() : super(null);

  Future<void> search(String query) async {
    if (query.isNotEmpty) {
      emit(await LastApi.searchTracks(query));
    } else {
      emit(null);
    }
  }
}
