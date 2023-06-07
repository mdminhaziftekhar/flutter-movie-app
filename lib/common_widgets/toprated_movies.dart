import 'package:bitmascot_assessment/constants/typography.dart';
import 'package:flutter/material.dart';

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
      // Reached the bottom of the ListView
      if (!isLoading) {
        loadTopRatedMovies();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Top Rated Movies',
            style: bodyFont16White,
          ),
          SizedBox(height: 10),
          Container(
              height: 270,
              child: ListView.builder(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  itemCount: topRatedMovies.length,
                  itemBuilder: (context, index) {
                    if (index == topRatedMovies.length - 1) {
                      // Reached the end, show the loading indicator
                      return Center(
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
                                      name:
                                          topRatedMovies[index]['title'] != null
                                              ? topRatedMovies[index]['title']
                                              : 'Sorry there are some error',
                                      bannerurl: topRatedMovies[index]
                                                  ['backdrop_path'] !=
                                              null
                                          ? 'https://image.tmdb.org/t/p/w500' +
                                              topRatedMovies[index]
                                                  ['backdrop_path']
                                          : 'https://via.placeholder.com/500x300.png?text=Default+Image',
                                      posterurl:
                                          'https://image.tmdb.org/t/p/w500' +
                                              topRatedMovies[index]
                                                  ['poster_path'],
                                      description: topRatedMovies[index]
                                                  ['overview'] !=
                                              null
                                          ? topRatedMovies[index]['overview']
                                          : 'There was a problem',
                                      vote: topRatedMovies[index]
                                                  ['vote_average'] !=
                                              null
                                          ? topRatedMovies[index]
                                                  ['vote_average']
                                              .toString()
                                          : 'There was a problem',
                                      launchedOn: topRatedMovies[index]
                                                  ['release_date'] !=
                                              null
                                          ? topRatedMovies[index]
                                              ['release_date']
                                          : 'There was a problem',
                                    )));
                      },
                      child: Container(
                        width: 140,
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                      'https://image.tmdb.org/t/p/w500' +
                                          topRatedMovies[index]['poster_path']),
                                ),
                              ),
                              height: 200,
                            ),
                            SizedBox(height: 5),
                            Container(
                              child: Text(
                                topRatedMovies[index]['title'] != null
                                    ? topRatedMovies[index]['title']
                                    : 'Loading',
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
}
