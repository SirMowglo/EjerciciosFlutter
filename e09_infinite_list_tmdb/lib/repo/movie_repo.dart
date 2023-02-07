import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/movie.dart';

class MovieRepo {
  Future<List<Result>> fetchMovies([int startIndex = 1]) async {
    final httpClient = http.Client();

    final response = await httpClient.get(
      Uri.https(
        'https://api.themoviedb.org/3',
        '/movie/popular',
        <String, String>{
          'page': '$startIndex',
          'api_key': '8eaeee91a7d280f08356724638c6c78b'
        },
      ),
    );

    if (response.statusCode == 200) {
      Movie movie = Movie.fromJson(jsonDecode(response.body));
      List<Result> results;

      results = movie.results;

      return results;
    }
    throw Exception('error fetching movies');
  }
}
