import 'package:flutter/material.dart';

import '../../common_widgets/popular_tv_widget.dart';
import '../../common_widgets/toprated_movies.dart';
import '../../common_widgets/trending_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Flutter Movie App'),
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        children: [
          PopularTV(),
          SizedBox(height: 20),
          TrendingMovies(),
          SizedBox(height: 20),
          TopRatedMovies(),
        ],
      ),
    );
  }
}
