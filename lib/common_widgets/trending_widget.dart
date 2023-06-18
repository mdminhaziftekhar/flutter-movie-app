import 'package:flutter/material.dart';

import '../constants/typography.dart';
import '../features/description/description.dart';
import '../services/api_services.dart';

class TrendingMovies extends StatefulWidget {
  const TrendingMovies({Key? key}) : super(key: key);

  @override
  State<TrendingMovies> createState() => _TrendingMoviesState();
}

class _TrendingMoviesState extends State<TrendingMovies> {
  final ApiService _apiService = ApiService();

  List trendingMovies = [];

  int trendingPage = 1;

  bool isLoading = false;

  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    loadTrendingMovies();
    _scrollController.addListener(_scrollListener);
  }

  Future<void> loadTrendingMovies() async {
    if (isLoading) return;

    setState(() {
      isLoading = true;
    });

    try {
      final movies = await _apiService.getTrendingMovies(trendingPage);
      setState(() {
        trendingMovies.addAll(movies);
        trendingPage++;
        isLoading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    }
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (!isLoading) {
        loadTrendingMovies();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _topTextWidget(),
          const SizedBox(height: 10),
          SizedBox(
              height: 270,
              child: ListView.builder(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  itemCount: trendingMovies.length,
                  itemBuilder: (context, index) {
                    if (index == trendingMovies.length - 1) {
                      // Reached the end, show the loading indicator
                      return const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 1,
                        ),
                      );
                    } else {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Description(
                                        name: trendingMovies[index]['title'] ??
                                            'Sorry there are some error',
                                        bannerurl: trendingMovies[index]
                                                    ['backdrop_path'] !=
                                                null
                                            ? 'https://image.tmdb.org/t/p/w500${trendingMovies[index]['backdrop_path']}'
                                            : 'https://via.placeholder.com/500x300.png?text=Default+Image',
                                        posterurl:
                                            'https://image.tmdb.org/t/p/w500${trendingMovies[index]['poster_path']}',
                                        description: trendingMovies[index]
                                                ['overview'] ??
                                            'There was a problem',
                                        vote: trendingMovies[index]
                                                    ['vote_average'] !=
                                                null
                                            ? trendingMovies[index]
                                                    ['vote_average']
                                                .toString()
                                            : 'There was a problem',
                                        launchedOn: trendingMovies[index]
                                                ['release_date'] ??
                                            'There was a problem',
                                      )));
                        },
                        child: SizedBox(
                          width: 140,
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        'https://image.tmdb.org/t/p/w500${trendingMovies[index]['poster_path']}'),
                                  ),
                                ),
                                height: 200,
                              ),
                              const SizedBox(height: 5),
                              SizedBox(
                                child: Text(
                                  trendingMovies[index]['title'] ?? 'Loading',
                                  style: bodyFont14White,
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }
                  }))
        ],
      ),
    );
  }

  Widget _topTextWidget() {
    return Text(
      'Trending Movies',
      style: h2BoldWhite,
    );
  }
}
