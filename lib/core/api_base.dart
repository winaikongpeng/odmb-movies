// ignore_for_file: constant_identifier_names

class ApiBase {
  static const SCHEME = 'http';
  static const URL = 'www.omdbapi.com';
  static const KEY = '1abc9ab2';

  static Uri getUriSearch(String input) => Uri(
      scheme: SCHEME, host: URL, queryParameters: {'apikey': KEY, 's': input});
  static Uri getUriDetailMovie(String id) =>
      Uri(scheme: SCHEME, host: URL, queryParameters: {'apikey': KEY, 'i': id});
}
