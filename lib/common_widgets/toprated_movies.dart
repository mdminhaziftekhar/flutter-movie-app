import 'package:flutter/material.dart';

import '../constants/typography.dart';
import '../features/description/description.dart';
import '../services/api_services.dart';

class TopRatedMovies extends StatefulWidget {
  const TopRatedMovies({Key? key}) : super(key: key);

  @override
  State<TopRatedMovies> createState() => _TopRatedMoviesState();
}

class _TopRatedMoviesState extends State<TopRatedMovies> {
  final ApiService _apiService = ApiService();
  List topRatedMovies = [];
  int topRatedPage = 1;
  bool isLoading = false;

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    loadTopRatedMovies();
    _scrollController.addListener(_scrollListener);
  }

  Future<void> loadTopRatedMovies() async {
    if (isLoading) return;

    setState(() {
      isLoading = true;
    });

    try {
      final movies = await _apiService.getTopRatedMovies(topRatedPage);
      setState(() {
        topRatedMovies.addAll(movies);
        topRatedPage++;
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
        loadTopRatedMovies();
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
                  itemCount: topRatedMovies.length,
                  itemBuilder: (context, index) {
                    if (index == topRatedMovies.length - 1) {
                      return const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 1,
                        ),
                      );
                    }
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Description(
                                      name: topRatedMovies[index]['title'] ??
                                          'Sorry there are some error',
                                      bannerurl: topRatedMovies[index]
                                                  ['backdrop_path'] !=
                                              null
                                          ? 'https://image.tmdb.org/t/p/w500${topRatedMovies[index]['backdrop_path']}'
                                          : 'https://via.placeholder.com/500x300.png?text=Default+Image',
                                      posterurl:
                                          'https://image.tmdb.org/t/p/w500${topRatedMovies[index]['poster_path']}',
                                      description: topRatedMovies[index]
                                              ['overview'] ??
                                          'There was a problem',
                                      vote: topRatedMovies[index]
                                                  ['vote_average'] !=
                                              null
                                          ? topRatedMovies[index]
                                                  ['vote_average']
                                              .toString()
                                          : 'There was a problem',
                                      launchedOn: topRatedMovies[index]
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
                                      'https://image.tmdb.org/t/p/w500${topRatedMovies[index]['poster_path']}'),
                                ),
                              ),
                              height: 200,
                            ),
                            const SizedBox(height: 5),
                            SizedBox(
                              child: Text(
                                topRatedMovies[index]['title'] ?? 'Loading',
                                style: bodyFont14White,
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }))
        ],
      ),
    );
  }

  Widget _topTextWidget() {
    return Text(
      'Top Rated Movies',
      style: bodyFont16White,
    );
  }
}
