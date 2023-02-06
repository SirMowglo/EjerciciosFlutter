part of 'movie_bloc.dart';

enum MovieStatus { initial, success, failure }

class MovieState extends Equatable {
  const MovieState({
    this.status = MovieStatus.initial,
    this.movies = const <Result>[],
    this.hasReachedMax = false,
  });

  final MovieStatus status;
  final List<Result> movies;
  final bool hasReachedMax;

  MovieState copyWith({
    MovieStatus? status,
    List<Result>? movies,
    bool? hasReachedMax,
  }) {
    return MovieState(
      status: status ?? this.status,
      movies: movies ?? this.movies,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status, hasReachedMax: $hasReachedMax, posts: ${movies.length} }''';
  }

  @override
  List<Object> get props => [status, movies, hasReachedMax];
}