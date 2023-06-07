import 'package:bitmascot_assessment/constants/typography.dart';
import 'package:flutter/material.dart';

import '../features/description/description.dart';

class TrendingMovies extends StatelessWidget {
  final List trending;

  const TrendingMovies({Key? key, required this.trending}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Trending Movies',
            style: h2BoldWhite,
          ),
          SizedBox(height: 10),
          Container(
              height: 270,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: trending.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Description(
                                      name: trending[index]['title'] != null
                                          ? trending[index]['title']
                                          : 'Sorry there are some error',
                                      bannerurl: trending[index]
                                                  ['backdrop_path'] !=
                                              null
                                          ? 'https://image.tmdb.org/t/p/w500' +
                                              trending[index]['backdrop_path']
                                          : 'https://via.placeholder.com/500x300.png?text=Default+Image',
                                      posterurl:
                                          'https://image.tmdb.org/t/p/w500' +
                                              trending[index]['poster_path'],
                                      description:
                                          trending[index]['overview'] != null
                                              ? trending[index]['overview']
                                              : 'There was a problem',
                                      vote: trending[index]['vote_average'] !=
                                              null
                                          ? trending[index]['vote_average']
                                              .toString()
                                          : 'There was a problem',
                                      launchedOn: trending[index]
                                                  ['release_date'] !=
                                              null
                                          ? trending[index]['release_date']
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
                                          trending[index]['poster_path']),
                                ),
                              ),
                              height: 200,
                            ),
                            SizedBox(height: 5),
                            Container(
                              child: Text(
                                trending[index]['title'] != null
                                    ? trending[index]['title']
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
