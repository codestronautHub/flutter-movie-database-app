class Urls {
  static const String baseUrl = 'https://api.nguonhpim.tv/index.php/ajax';
  static const String baseUrlSingle = '$baseUrl/recommended?mid=1&type=single';
  static const String baseUrlSerial = '$baseUrl/recommended?mid=1&type=serial';

  ///single
  static const String nowPlayingMovies = '$baseUrlSingle&by=hits_day';
  static const String popularMovies = '$baseUrlSingle&by=hits_month';
  static const String topChineseMovies = '$baseUrlSingle&by=up&tid=13';
  static const String topHqMovies = '$baseUrlSingle&by=up&tid=16';
  static const String topAcMovies = '$baseUrlSingle&by=up&tid=8';
  static const String topRatedMovies = '$baseUrlSingle&by=score';
  static String movieDetail(int id) => '$baseUrl/details?mid=1&id=$id';
  static String movieRecommendations(int id) => '$baseUrlSingle&tid=$id';
  static String searchMovies(String query) =>
      '$baseUrl/suggest?mid=1&type=single&wd=$query';

  /// serial
  static const String onTheAirTvs = '$baseUrlSerial&by=hits_day';
  static const String popularTvs = '$baseUrlSerial&by=hits_month';
  static const String topRatedTvs = '$baseUrlSerial&by=score';
  static const String topTqTvs = '$baseUrlSerial&by=up&tid=13';
  static const String topHqTvs = '$baseUrlSerial&by=up&tid=16';
  static const String topAcTvs = '$baseUrlSerial&by=up&tid=8';
  static String tvDetail(int id) => '$baseUrl/details?mid=1&id=$id&type=serial';
  static String tvSeasons(int id) => '$baseUrl/tv/$id/season/?';
  static String tvRecommendations(int id) => '$baseUrlSerial&by=score';
  static String searchTvs(String query) =>
      '$baseUrl/suggest?mid=1&wd=$query&type=serial';
}
