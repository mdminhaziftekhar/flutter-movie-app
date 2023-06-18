import 'package:flutter/material.dart';

import '../../constants/typography.dart';

class Description extends StatelessWidget {
  final String name, description, bannerurl, posterurl, vote, launchedOn;

  const Description(
      {Key? key,
      required this.name,
      required this.description,
      required this.bannerurl,
      required this.posterurl,
      required this.vote,
      required this.launchedOn})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(children: [
        _topImageWidget(context),
        const SizedBox(height: 15),
        _nameWidget(),
        _launchDateWidget(),
        _descriptionWidget(),
      ]),
    );
  }

  Widget _descriptionWidget() {
    return Row(
      children: [
        _bottomImageWidget(),
        _bottomTextWidget(),
      ],
    );
  }

  Widget _bottomTextWidget() {
    return Flexible(
      child: Container(
          padding: const EdgeInsets.all(10),
          child: Text(
            description,
            style: bodyFont14White,
          )),
    );
  }

  Widget _bottomImageWidget() {
    return SizedBox(
      height: 200,
      width: 100,
      child: Image.network(posterurl),
    );
  }

  Widget _launchDateWidget() {
    return Container(
        padding: const EdgeInsets.only(left: 10),
        child: Text(
          'Releasing On - $launchedOn',
          style: bodyFont16White,
        ));
  }

  Widget _nameWidget() {
    return Container(
        padding: const EdgeInsets.all(10),
        child: Text(
          name,
          style: h2Bold,
        ));
  }

  Widget _topImageWidget(BuildContext context) {
    return SizedBox(
        height: 250,
        child: Stack(children: [
          Positioned(
            child: SizedBox(
              height: 250,
              width: MediaQuery.of(context).size.width,
              child: Image.network(
                bannerurl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
              bottom: 10,
              child: Text(
                '⭐ Average Rating - $vote',
                style: bodyFont16White,
              )),
        ]));
  }
}
