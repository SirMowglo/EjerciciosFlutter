import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/movie.dart';

class MovieRepo {
  Future<List<Result>> fetchMovies([int startIndex = 0]) async {
    final httpClient = http.Client();

    final response = await httpClient.get(
      Uri.https(
        'jsonplaceholder.typicode.com',
        '/posts',
        <String, String>{'page': '$startIndex'},
      ),
    );
    if (response.statusCode == 200) {
      List<dynamic> list = jsonDecode(response.body);
      List<Movie> movieList = [];

      list.map((e) => movieList.add(Movie.fromJson(e))).toList();

      return movieList;
    }
    throw Exception('error fetching posts');
  }
}
