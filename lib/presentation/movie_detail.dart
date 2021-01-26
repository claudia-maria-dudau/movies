import 'package:movies/containers/movie_container.dart';
import 'package:movies/models/index.dart';
import 'package:flutter/material.dart';

class MovieDetail extends StatelessWidget {
  const MovieDetail({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MovieContainer(
      builder: (BuildContext context, Movie movie) {
        return Scaffold(
          appBar: AppBar(
            title: Center(child: Text(movie.title)),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: <Widget>[
                Image.network(movie.largeCoverImage),
                const Text(''),
                Text(
                  'Year: ${movie.year}',
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
                const Text(''),
                Text(
                  'Genres: ${movie.genres.join(', ')}',
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
                const Text(''),
                Text(
                  'Runtime: ${movie.runtime} minute',
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
                const Text(''),
                Text(
                  'Rating: ${movie.rating}',
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
                const Text(''),
                Text(
                  'Summary: ${movie.summary}',
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
