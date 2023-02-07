import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/movie.dart';

class MovieRepo {
  Future<List<Result>> fetchMovies(int page) async {
    final response =
        await http.get(Uri.parse('https://api.themoviedb.org/3/movie/popular?page=$page&api_key=8eaeee91a7d280f08356724638c6c78b'));

      if(response.statusCode == 200){
        Movie movie = Movie.fromJson(jsonDecode(response.body));
        List<Result> results;
        results = movie.movies ?? [];

        return results;
      }else{
        throw Exception('Failed to load Movies');
      }
    }
  
}
