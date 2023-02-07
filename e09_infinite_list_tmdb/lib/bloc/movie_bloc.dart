import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:stream_transform/stream_transform.dart';

import '../model/movie.dart';
import '../repo/movie_repo.dart';

part 'movie_event.dart';
part 'movie_state.dart';

int moviePage = 1;
const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieBloc({required this.httpClient}) : super(const MovieState()) {
    on<MovieFetched>(
      _onMovieFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  final http.Client httpClient;

  Future<void> _onMovieFetched(
    MovieFetched event,
    Emitter<MovieState> emit,
  ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == MovieStatus.initial) {
        final movies = await MovieRepo().fetchMovies(moviePage);
        print(movies);
        return emit(
          state.copyWith(
            status: MovieStatus.success,
            movies: movies,
            hasReachedMax: false,
          ),
        );
      }

      moviePage++;

      final movies = await MovieRepo().fetchMovies(moviePage);
      movies.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(
              state.copyWith(
                status: MovieStatus.success,
                movies: List.of(state.movies)..addAll(movies),
                hasReachedMax: false,
              ),
            );
    } catch (_) {
      emit(state.copyWith(status: MovieStatus.failure));
    }
  }
}
