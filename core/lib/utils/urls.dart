class Urls {
  static const String baseUrl = 'https://api.nguonhpim.tv/index.php/ajax';
  static const String baseUrlSingle = '$baseUrl/recommended?mid=1&type=single';

  ///single
  static const String nowPlayingMovies =
      '$baseUrlSingle&by=hits_day';
  static const String popularMovies =
      '$baseUrlSingle&by=hits_month';
  static const String topChineseMovies =
      '$baseUrlSingle&by=up&tid=13';
  static const String topHqMovies =
      '$baseUrlSingle&by=up&tid=16';
  static const String topAcMovies =
      '$baseUrlSingle&by=up&tid=8';
  static const String topRatedMovies =
      '$baseUrlSingle&by=score';
  static String movieDetail(int id) => '$baseUrl/details?mid=1&id=$id';
  static String movieRecommendations(int id) =>
      '$baseUrlSingle&tid=$id';
  static String searchMovies(String query) =>
      '$baseUrl/suggest?mid=1&type=single&wd=$query';

  /// serial
  static const String onTheAirTvs =
      '$baseUrl/recommended?mid=1&by=hits_day&tid=2';
  static const String popularTvs =
      '$baseUrl/recommended?mid=1&by=hits_month&tid=2';
  static const String topRatedTvs = '$baseUrl/recommended?mid=1&by=score&tid=2';
  static String tvDetail(int id) => '$baseUrl/details?mid=1&id=$id&tid=2';
  static String tvSeasons(int id) => '$baseUrl/tv/$id/season/?';
  static String tvRecommendations(int id) => '$baseUrl/tv/$id/recommendations?';
  static String searchTvs(String query) => '$baseUrl/search/tv?&query=$query';

  /// Image
  static String movieImages(int id) =>
      '$baseUrl/movie/$id/images?&language=en-US&include_image_language=en,null';
  static String tvImages(int id) =>
      '$baseUrl/tv/$id/images?&language=en-US&include_image_language=en,null';
}
