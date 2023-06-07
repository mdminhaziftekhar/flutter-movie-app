import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../common_widgets/popular_tv_widget.dart';
import '../../common_widgets/toprated_movies.dart';
import '../../common_widgets/trending_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String apiKey = '22b49a657ae3ae5c9ae448d2f2b12523';
  final String trendingUrl = 'https://api.themoviedb.org/3/trending/movie/day';
  final String topRatedUrl = 'https://api.themoviedb.org/3/movie/top_rated';
  final String popularTvUrl = 'https://api.themoviedb.org/3/movie/popular';

  List trendingMovies = [];
  List topRatedMovies = [];
  List tvShows = [];

  @override
  void initState() {
    super.initState();
    loadMovies();
  }

  Future<void> loadMovies() async {
    await loadTrendingMovies();
    await loadTopRatedMovies();
    await loadPopularTvShows();
  }

  Future<void> loadTrendingMovies() async {
    final url = '$trendingUrl?api_key=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        trendingMovies = data['results'];
      });
    } else {
      print('Failed to load trending movies');
    }
  }

  Future<void> loadTopRatedMovies() async {
    final url = '$topRatedUrl?api_key=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        topRatedMovies = data['results'];
      });
    } else {
      print('Failed to load top rated movies');
    }
  }

  Future<void> loadPopularTvShows() async {
    final url = '$popularTvUrl?api_key=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        tvShows = data['results'];
      });
    } else {
      print('Failed to load popular TV shows');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Flutter Movie App ❤️'),
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        children: [
          PopularTV(tv: tvShows),
          TrendingMovies(trending: trendingMovies),
          TopRatedMovies(toprated: topRatedMovies),
        ],
      ),
    );
  }
}
