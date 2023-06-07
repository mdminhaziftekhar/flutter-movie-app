import 'package:bitmascot_assessment/constants/typography.dart';
import 'package:flutter/material.dart';

import '../features/description/description.dart';

class TopRatedMovies extends StatelessWidget {
  final List toprated;

  const TopRatedMovies({Key? key, required this.toprated}) : super(key: key);
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
                  scrollDirection: Axis.horizontal,
                  itemCount: toprated.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Description(
                                      name: toprated[index]['title'] != null
                                          ? toprated[index]['title']
                                          : 'Sorry there are some error',
                                      bannerurl: toprated[index]
                                                  ['backdrop_path'] !=
                                              null
                                          ? 'https://image.tmdb.org/t/p/w500' +
                                              toprated[index]['backdrop_path']
                                          : 'https://via.placeholder.com/500x300.png?text=Default+Image',
                                      posterurl:
                                          'https://image.tmdb.org/t/p/w500' +
                                              toprated[index]['poster_path'],
                                      description:
                                          toprated[index]['overview'] != null
                                              ? toprated[index]['overview']
                                              : 'There was a problem',
                                      vote: toprated[index]['vote_average'] !=
                                              null
                                          ? toprated[index]['vote_average']
                                              .toString()
                                          : 'There was a problem',
                                      launchedOn: toprated[index]
                                                  ['release_date'] !=
                                              null
                                          ? toprated[index]['release_date']
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
                                          toprated[index]['poster_path']),
                                ),
                              ),
                              height: 200,
                            ),
                            SizedBox(height: 5),
                            Container(
                              child: Text(
                                toprated[index]['title'] != null
                                    ? toprated[index]['title']
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
