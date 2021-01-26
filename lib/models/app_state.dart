part of models;

abstract class AppState implements Built<AppState, AppStateBuilder> {
  factory AppState([void Function(AppStateBuilder) updates]) = _$AppState;

  factory AppState.initialState() {
    final AppStateBuilder builder = AppStateBuilder();
    builder
      ..isLoading = true
      ..page = 1
      ..title = ''
      ..quality = 'All'
      ..genre = 'All'
      ..orderBy = 'desc'
      ..message = '';

    return builder.build();
  }

  AppState._();

  BuiltList<Movie> get movies;

  bool get isLoading;

  int get page;

  String get title;

  String get quality;

  String get genre;

  String get orderBy;

  @nullable
  int get selectedMovie;

  String get message;
}

/* flutter pub run build_runner watch --delete-conflicting-outputs */
