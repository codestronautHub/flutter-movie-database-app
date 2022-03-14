class Urls {
  static const String baseUrl = 'https://api.nguonhpim.tv/index.php/ajax';

  /// Movies
  static const String nowPlayingMovies =
      '$baseUrl/recommended?mid=1&by=hits_day';
  static const String popularMovies =
      '$baseUrl/recommended?mid=1&by=hits_month';
  static const String topChineseMovies =
      '$baseUrl/recommended?mid=1&by=up&tid=13';
  static const String topHqMovies =
      '$baseUrl/recommended?mid=1&by=up&tid=16';
  static const String topRatedMovies = '$baseUrl/recommended?mid=1&by=score';
  static String movieDetail(int id) => '$baseUrl/details?mid=1&id=$id';
  static String movieRecommendations(int id) =>
      '$baseUrl/recommended?mid=1&tid=$id';
  static String searchMovies(String query) =>
      '$baseUrl/suggest?mid=1&wd=$query';

  /// Tvs
  static const String onTheAirTvs =
      '$baseUrl/recommended?mid=1&by=hits_day&tid=2';
  static const String popularTvs =
      '$baseUrl/recommended?mid=1&by=hits_month&tid=2';
  static const String topRatedTvs = '$baseUrl/recommended?mid=1&by=score&tid=2';
  static String tvDetail(int id) => '$baseUrl/details?mid=1&id=$id&tid=2';
  static String tvSeasons(int id) => '$baseUrl/tv/$id/season/?';
  static String tvRecommendations(int id) =>
      '$baseUrl/recommended?mid=1&by=score&tid=2';
  static String searchTvs(String query) => '$baseUrl/search/tv?&query=$query';

  /// Image
  static String movieImages(int id) =>
      '$baseUrl/movie/$id/images?&language=en-US&include_image_language=en,null';
  static String tvImages(int id) =>
      '$baseUrl/tv/$id/images?&language=en-US&include_image_language=en,null';
}
