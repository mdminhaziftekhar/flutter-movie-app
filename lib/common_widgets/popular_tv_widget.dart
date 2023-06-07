import 'package:bitmascot_assessment/constants/typography.dart';
import 'package:flutter/material.dart';

import '../features/description/description.dart';

class PopularTV extends StatelessWidget {
  final List tv;

  const PopularTV({Key? key, required this.tv}) : super(key: key);
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
                  scrollDirection: Axis.horizontal,
                  itemCount: tv.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Description(
                                      name: tv[index]['title'] != null
                                          ? tv[index]['title']
                                          : 'Sorry there are some error',
                                      bannerurl: tv[index]['backdrop_path'] !=
                                              null
                                          ? 'https://image.tmdb.org/t/p/w500' +
                                              tv[index]['backdrop_path']
                                          : 'https://via.placeholder.com/500x300.png?text=Default+Image',
                                      posterurl:
                                          'https://image.tmdb.org/t/p/w500' +
                                              tv[index]['poster_path'],
                                      description: tv[index]['overview'] != null
                                          ? tv[index]['overview']
                                          : 'There was a problem',
                                      vote: tv[index]['vote_average'] != null
                                          ? tv[index]['vote_average'].toString()
                                          : 'There was a problem',
                                      launchedOn:
                                          tv[index]['release_date'] != null
                                              ? tv[index]['release_date']
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
                                    image: NetworkImage(tv[index]
                                                ['backdrop_path'] !=
                                            null
                                        ? 'https://image.tmdb.org/t/p/w500' +
                                            tv[index]['backdrop_path']
                                        : 'https://via.placeholder.com/500x300.png?text=Default+Image'),
                                    fit: BoxFit.cover),
                              ),
                              height: 140,
                            ),
                            SizedBox(height: 5),
                            Container(
                              child: Text(
                                tv[index]['original_title'] != null
                                    ? tv[index]['original_title']
                                    : 'There was a problem',
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
