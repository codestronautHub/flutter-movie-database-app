class Urls {
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String baseImageUrl = 'https://image.tmdb.org/t/p/w500';
  static const String apiKey = 'api_key=2174d146bb9c0eab47529b2e77d6b526';

  // Movies

  // Tvs
  static const String onTheAirTvs = '$baseUrl/tv/on_the_air?$apiKey';
  static const String popularTvs = '$baseUrl/tv/popular?$apiKey';
  static const String topRatedTvs = '$baseUrl/tv/top_rated?$apiKey';
}
