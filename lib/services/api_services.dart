import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  final String apiKey = '22b49a657ae3ae5c9ae448d2f2b12523';
  final String trendingUrl = 'https://api.themoviedb.org/3/trending/movie/day';
  final String topRatedUrl = 'https://api.themoviedb.org/3/movie/top_rated';
  final String popularTvUrl = 'https://api.themoviedb.org/3/movie/popular';

  Future<List> getTrendingMovies(int page) async {
    final url = '$trendingUrl?api_key=$apiKey&page=$page';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['results'];
    } else {
      throw Exception('Failed to load trending movies');
    }
  }

  Future<List> getTopRatedMovies(int page) async {
    final url = '$topRatedUrl?api_key=$apiKey&page=$page';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['results'];
    } else {
      throw Exception('Failed to load top rated movies');
    }
  }

  Future<List> getPopularTvShows(int page) async {
    final url = '$popularTvUrl?api_key=$apiKey&page=$page';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['results'];
    } else {
      throw Exception('Failed to load popular TV shows');
    }
  }
}
