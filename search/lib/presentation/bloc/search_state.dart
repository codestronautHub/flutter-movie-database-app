part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object?> get props => [];
}

class SearchEmpty extends SearchState {}

class SearchLoading extends SearchState {}

class SearchError extends SearchState {
  final String message;

  const SearchError(this.message);

  @override
  List<Object?> get props => [message];
}

class MovieSearchHasData extends SearchState {
  final List<Movie> result;

  const MovieSearchHasData(this.result);

  @override
  List<Object?> get props => [result];
}

class TvSearchHasData extends SearchState {
  final List<Tv> result;

  const TvSearchHasData(this.result);

  @override
  List<Object?> get props => [result];
}
