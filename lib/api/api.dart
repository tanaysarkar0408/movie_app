import 'dart:convert';
import 'package:movie_app/constants.dart';
import 'package:movie_app/models/movie.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/screens/homeScreen.dart';

class Api {
  Api._instantiate();
  static final Api instance = Api._instantiate();
  static const _trendingUrl =
      'https://api.themoviedb.org/3/trending/movie/day?api_key=${Constants.apiKey}';
  static const _topRatedUrl =
      'https://api.themoviedb.org/3/movie/top_rated?api_key=${Constants.apiKey}';
  static const _upcomingUrl =
      'https://api.themoviedb.org/3/movie/upcoming?api_key=${Constants.apiKey}';
  static const _searchedMovieUrl =
      'https://api.themoviedb.org/3/search/movie?api_key=${Constants.apiKey}';

  Future<List<Movie>> getTrendingMovies() async {
    final response = await http.get(Uri.parse(_trendingUrl));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      print('getTrendingMovies$decodedData');
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Something happened');
    }
  }

  Future<List<Movie>> getTopRatedMovies() async {
    final response = await http.get(Uri.parse(_topRatedUrl));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Something happened');
    }
  }

  Future<List<Movie>> getUpcomingMovies() async {
    final response = await http.get(Uri.parse(_upcomingUrl));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Something happened');
    }
  }

  Future<List<Movie>> getSearchedMovies({required String movieName}) async {
    print('API WALA $movieName');
    var url = '$_searchedMovieUrl&query=$movieName';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Something Happend');
    }
  }
// Future<List<Movie>> getSearchedMovies({required String movieName}) async {
//     List<Movie> movieList = [];
//   var url = '$_searchedMovieUrl&query=$movieName';
//   final response = await http.get(Uri.parse(url));
//   if (response.statusCode == 200) {
//     final decodedData = json.decode(response.body)['results'] as List;
//     decodedData.forEach((showData) {
//       Movie movies = Movie.fromJson(showData);
//       movieList.add(movies);
//       print(showData['original_title']);
//     });
//     return movieList;
//     // return decodedData.map((movie) => Movie.fromJson(movie)).toList();
//
//   } else {
//     throw Exception('Something happened');
//   }
// }
}
