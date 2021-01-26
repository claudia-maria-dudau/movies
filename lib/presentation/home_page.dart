import 'package:movies/actions/index.dart';
import 'package:movies/containers/genre_container.dart';
import 'package:movies/containers/is_loading_container.dart';
import 'package:movies/containers/message_container.dart';
import 'package:movies/containers/movies_container.dart';
import 'package:movies/containers/order_by_container.dart';
import 'package:movies/containers/page_container.dart';
import 'package:movies/containers/quality_container.dart';
import 'package:movies/models/index.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _textField = TextEditingController();
  String _inputValue = '';
  List<String> genres = <String>[
    'All',
    'Action',
    'Adventure',
    'Animation',
    'Biography',
    'Comedy',
    'Crime',
    'Documentary',
    'Drama',
    'Family',
    'Fantasy',
    'Film Noir',
    'History',
    'Horror',
    'Music',
    'Musical',
    'Mystery',
    'Romance',
    'Sci-Fi',
    'Short Film',
    'Sport',
    'Superhero',
    'Thriller',
    'War',
    'Western',
  ];

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      builder: (BuildContext context, int page) {
        return IsLoadingContainer(
          builder: (BuildContext context, bool isLoading) {
            return Scaffold(
              appBar: AppBar(
                title: Center(
                  child: Text('${widget.title} - $page'),
                ),
                actions: <Widget>[
                  OrderByContainer(
                    builder: (BuildContext context, String orderBy) {
                      return IconButton(
                        icon: Icon(orderBy == 'desc'
                            ? Icons.keyboard_arrow_down
                            : Icons.keyboard_arrow_up),
                        onPressed: () {
                          StoreProvider.of<AppState>(context)
                            ..dispatch(UpdateOrderBy(orderBy))
                            ..dispatch(const GetMovies());
                        },
                      );
                    },
                  ),
                ],
              ),
              body: Column(
                children: <Widget>[
                  //title
                  TextField(
                    onChanged: (String value) {
                      setState(
                        () {
                          _inputValue = value;
                        },
                      );

                      StoreProvider.of<AppState>(context)
                        ..dispatch(UpdateTitle(_inputValue))
                        ..dispatch(const GetMovies());
                    },
                    controller: _textField,
                    decoration: InputDecoration(
                      hintText: 'Search by title',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          _textField.clear();
                          setState(
                            () {
                              _inputValue = '';
                            },
                          );
                        },
                        child: const Icon(Icons.close),
                      ),
                    ),
                  ),

                  //quality
                  QualityContainer(
                    builder: (BuildContext context, String quality) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Padding(
                            padding: EdgeInsets.only(right: 8),
                            child: Text('Quality:'),
                          ),
                          DropdownButton<String>(
                            value: StoreProvider.of<AppState>(context)
                                .state
                                .quality,
                            items: <String>[
                              'All',
                              '720p',
                              '1080p',
                              '2160p',
                              '3D'
                            ].map(
                              (String quality) {
                                return DropdownMenuItem<String>(
                                  value: quality,
                                  child: Text(quality),
                                );
                              },
                            ).toList(),
                            onChanged: (String value) {
                              StoreProvider.of<AppState>(context)
                                ..dispatch(UpdateQuality(value))
                                ..dispatch(const GetMovies());
                            },
                          ),
                        ],
                      );
                    },
                  ),

                  //genre
                  GenreContainer(
                    builder: (BuildContext build, String genre) {
                      return Container(
                        height: 50,
                        child: ListView.builder(
                          itemCount: genres.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return ChoiceChip(
                              label: Text(genres[index]),
                              selected: genre == genres[index],
                              onSelected: (bool selected) {
                                StoreProvider.of<AppState>(context)
                                  ..dispatch(UpdateGenre(genres[index]))
                                  ..dispatch(const GetMovies());
                              },
                            );
                          },
                        ),
                      );
                    },
                  ),

                  Builder(
                    builder: (BuildContext context) {
                      if (isLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      //movies
                      return MoviesContainer(
                        builder:
                            (BuildContext context, BuiltList<Movie> movies) {
                          return Expanded(
                            child: Column(
                              children: <Widget>[
                                MessageContainer(
                                  builder:
                                      (BuildContext context, String message) {
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 4),
                                      child: Center(child: Text(message)),
                                    );
                                  },
                                ),
                                Expanded(
                                  child: GridView.builder(
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 1,
                                      mainAxisSpacing: 16,
                                    ),
                                    itemCount: movies.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final Movie _movie = movies[index];

                                      return GestureDetector(
                                        onTap: () {
                                          StoreProvider.of<AppState>(context)
                                              .dispatch(SetSelectedMovie(
                                                  _movie.movieId));
                                          Navigator.pushNamed(
                                              context, '/movieDetail');
                                        },
                                        child: Card(
                                          elevation: 5.0,
                                          shadowColor: Colors.indigoAccent,
                                          child: Column(
                                            children: <Widget>[
                                              ListTile(
                                                title: Center(
                                                  child: Text(
                                                    _movie.title,
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                subtitle: Center(
                                                  child: Text(
                                                    '(${_movie.year})',
                                                    style: const TextStyle(
                                                      color: Colors.blueGrey,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 8),
                                                  child: Column(
                                                    children: <Widget>[
                                                      Text(
                                                        'Genres: ${_movie.genres.join(', ')}',
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                      const Text(''),
                                                      Expanded(
                                                          child: Image.network(
                                                              _movie
                                                                  .mediumCoverImage)),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                  Container(
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return ChoiceChip(
                          label: Text('${index + 1}'),
                          selected: page == index + 1,
                          onSelected: (bool selected) {
                            StoreProvider.of<AppState>(context)
                              ..dispatch(UpdatePage(index + 1))
                              ..dispatch(const GetMovies());
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
