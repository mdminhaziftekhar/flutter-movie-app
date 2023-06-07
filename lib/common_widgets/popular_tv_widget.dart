import 'package:bitmascot_assessment/constants/typography.dart';
import 'package:flutter/material.dart';

import '../features/description/description.dart';
import '../services/api_services.dart';

class PopularTV extends StatefulWidget {
  const PopularTV({Key? key}) : super(key: key);

  @override
  State<PopularTV> createState() => _PopularTVState();
}

class _PopularTVState extends State<PopularTV> {
  final ApiService _apiService = ApiService();
  List tvShows = [];
  int popularPage = 1;

  bool isLoading = false;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    loadPopularTvShows();
    _scrollController.addListener(_scrollListener);
  }

  Future<void> loadPopularTvShows() async {
    if (isLoading) return;

    setState(() {
      isLoading = true;
    });

    try {
      final movies = await _apiService.getPopularTvShows(popularPage);
      setState(() {
        tvShows.addAll(movies);
        popularPage++;
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
        loadPopularTvShows();
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
            'Popular TV Shows',
            style: h2BoldWhite,
          ),
          SizedBox(height: 10),
          Container(
              // color: Colors.red,
              height: 200,
              child: ListView.builder(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  itemCount: tvShows.length,
                  itemBuilder: (context, index) {
                    if (index == tvShows.length - 1) {
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
                                        name: tvShows[index]['title'] != null
                                            ? tvShows[index]['title']
                                            : 'Sorry there are some error',
                                        bannerurl: tvShows[index]
                                                    ['backdrop_path'] !=
                                                null
                                            ? 'https://image.tmdb.org/t/p/w500' +
                                                tvShows[index]['backdrop_path']
                                            : 'https://via.placeholder.com/500x300.png?text=Default+Image',
                                        posterurl:
                                            'https://image.tmdb.org/t/p/w500' +
                                                tvShows[index]['poster_path'],
                                        description:
                                            tvShows[index]['overview'] != null
                                                ? tvShows[index]['overview']
                                                : 'There was a problem',
                                        vote: tvShows[index]['vote_average'] !=
                                                null
                                            ? tvShows[index]['vote_average']
                                                .toString()
                                            : 'There was a problem',
                                        launchedOn: tvShows[index]
                                                    ['release_date'] !=
                                                null
                                            ? tvShows[index]['release_date']
                                            : 'There was a problem',
                                      )));
                        },
                        child: Container(
                          padding: EdgeInsets.all(5),
                          // color: Colors.green,
                          width: 250,
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      image: NetworkImage(tvShows[index]
                                                  ['backdrop_path'] !=
                                              null
                                          ? 'https://image.tmdb.org/t/p/w500' +
                                              tvShows[index]['backdrop_path']
                                          : 'https://via.placeholder.com/500x300.png?text=Default+Image'),
                                      fit: BoxFit.cover),
                                ),
                                height: 140,
                              ),
                              SizedBox(height: 5),
                              Container(
                                child: Text(
                                  tvShows[index]['original_title'] != null
                                      ? tvShows[index]['original_title']
                                      : 'There was a problem',
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
}
