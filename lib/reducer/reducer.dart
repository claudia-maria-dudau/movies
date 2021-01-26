import 'package:movies/actions/index.dart';
import 'package:movies/models/index.dart';
import 'package:redux/redux.dart';

Reducer<AppState> reducer = combineReducers(<Reducer<AppState>>[
  TypedReducer<AppState, GetMoviesStart>(_getMoviesStart),
  TypedReducer<AppState, GetMoviesSuccessful>(_getMoviesSuccessful),
  TypedReducer<AppState, GetMoviesError>(_getMoviesError),
  TypedReducer<AppState, UpdatePage>(_updatePage),
  TypedReducer<AppState, UpdateTitle>(_updateTitle),
  TypedReducer<AppState, UpdateQuality>(_updateQuality),
  TypedReducer<AppState, UpdateGenre>(_updateGenre),
  TypedReducer<AppState, UpdateOrderBy>(_updateOrderBy),
  TypedReducer<AppState, SetSelectedMovie>(_setSelectedMovie),
]);

AppState _getMoviesStart(AppState state, GetMoviesStart action) {
  return state.rebuild((AppStateBuilder b) =>
  b
    ..isLoading = true
    ..message = ''
  );
}

AppState _getMoviesSuccessful(AppState state, GetMoviesSuccessful action) {
  return state.rebuild((AppStateBuilder b) =>
  b
    ..isLoading = false
    ..message = ''
    ..movies.addAll(action.movies)
  );
}

AppState _getMoviesError(AppState state, GetMoviesError action) {
  return state.rebuild((AppStateBuilder b) =>
  b
    ..isLoading = false
    ..message = 'Nu exista filme'
  );
}

AppState _updatePage(AppState state, UpdatePage action) {
  return state.rebuild((AppStateBuilder b) =>
  b
    ..movies.clear()
    ..page = action.page
  );
}


AppState _updateTitle(AppState state, UpdateTitle action) {
  return state.rebuild((AppStateBuilder b) =>
  b
    ..movies.clear()
    ..title = action.title
    ..page = 1
  );
}

AppState _updateQuality(AppState state, UpdateQuality action) {
  return state.rebuild((AppStateBuilder b) =>
  b
    ..movies.clear()
    ..quality = action.quality
    ..page = 1
  );
}

AppState _updateGenre(AppState state, UpdateGenre action) {
  return state.rebuild((AppStateBuilder b) =>
  b
    ..movies.clear()
    ..genre = action.genre
    ..page = 1
  );
}

AppState _updateOrderBy(AppState state, UpdateOrderBy action) {
  return state.rebuild((AppStateBuilder b) =>
  b
    ..movies.clear()
    ..orderBy = action.orderBy == 'desc' ? 'asc' : 'desc'
    ..page = 1
  );
}

AppState _setSelectedMovie(AppState state, SetSelectedMovie action) {
  return state.rebuild((AppStateBuilder b) => b.selectedMovie = action.movieId);
}