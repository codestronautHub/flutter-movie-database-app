import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import '../../domain/usecases/search_movies.dart';
import '../../domain/usecases/search_tvs.dart';

part 'search_event.dart';
part 'search_state.dart';

class MovieSearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchMovies _searchMovies;

  MovieSearchBloc(this._searchMovies) : super(SearchEmpty()) {
    on<OnQueryChanged>(
      (event, emit) async {
        final query = event.query;

        emit(SearchLoading());
        final result = await _searchMovies.execute(query);

        result.fold(
          (failure) {
            emit(SearchError(failure.message));
          },
          (data) {
            emit(MovieSearchHasData(data));
          },
        );
      },
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }
}

class TvSearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchTvs _searchTvs;

  TvSearchBloc(this._searchTvs) : super(SearchEmpty()) {
    on<OnQueryChanged>(
      (event, emit) async {
        final query = event.query;

        emit(SearchLoading());
        final result = await _searchTvs.execute(query);

        result.fold(
          (failure) {
            emit(SearchError(failure.message));
          },
          (data) {
            emit(TvSearchHasData(data));
          },
        );
      },
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
