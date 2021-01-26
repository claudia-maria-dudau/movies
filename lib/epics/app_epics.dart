import 'package:movies/actions/index.dart';
import 'package:movies/data/yts_api.dart';
import 'package:movies/models/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

class AppEpics {
  const AppEpics({@required YtsApi ytsApi})
      : assert(ytsApi != null),
        _ytsApi = ytsApi;

  final YtsApi _ytsApi;

  Epic<AppState> get epics {
    return combineEpics<AppState>(<Epic<AppState>>[
      TypedEpic<AppState, GetMoviesStart>(_getMoviesStart),
    ]);
  }

  Stream<dynamic> _getMoviesStart(Stream<GetMoviesStart> actions,
      EpicStore<AppState> store) {
    return actions
        .asyncMap((GetMoviesStart event) =>
        _ytsApi.getMovies(
          store.state.page,
          store.state.title,
          store.state.quality,
          store.state.genre,
          store.state.orderBy,
        ))
        .map((List<Movie> event) => GetMovies.successful(event))
        .onErrorReturnWith((dynamic error) => GetMovies.error(error));
  }
}