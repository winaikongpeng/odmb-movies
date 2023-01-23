import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tbc_test/models/detail_movie.dart';
import 'common_widget.dart';

class MovieWidgets {
  static Widget cardMovieWidget(String poster, String title, String year,
      String type, void Function()? onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Container(
          color: Colors.grey,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  width: 200,
                  height: 200,
                  color: Colors.transparent,
                  child: CachedNetworkImage(
                    imageUrl: poster,
                    placeholder: (context, url) => CommonWidget.loading(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title),
                  Text('year : $year'),
                  Text('type : $type'),
                ],
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Container(
                  width: 100,
                  height: 100,
                  color: Colors.transparent,
                  child: const Icon(
                    Icons.arrow_right_alt_outlined,
                    size: 50,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget headderDetailMovie(
    BuildContext context, {
    required String poster,
    required String title,
    required String year,
    required String director,
    required String country,
    required String actors,
    required String genre,
    required String awards,
    required String language,
    required String writer,
    required String boxOffice,
    required String rated,
    required String production,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Container(
        color: Colors.grey,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildImage(context, poster),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  buildTextDetail('year', year),
                  buildTextDetail('director', director),
                  buildTextDetail('actors', actors),
                  buildTextDetail('writer', writer),
                  buildTextDetail('genre', genre),
                  buildTextDetail('awards', awards),
                  buildTextDetail('country', country),
                  buildTextDetail('language', language),
                  buildTextDetail('boxOffice', boxOffice),
                  buildTextDetail('rated', rated),
                  buildTextDetail('production', production),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  static Widget buildTextDetail(String title, String detail) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Text(
            '$title : ',
            style: const TextStyle(color: Colors.white),
          ),
          Text('$detail '),
        ],
      ),
    );
  }

  static Widget buildTextDetailPlot(BuildContext context, String plot) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 10, top: 20),
          child: Text(
            'Plot',
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Container(
            color: Colors.grey,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width * 0.8,
                    color: Colors.transparent,
                    child: Text(
                      '$plot ',
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  static Padding buildImage(BuildContext context, String poster) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
          width: MediaQuery.of(context).size.width * 0.3,
          height: 350,
          color: Colors.transparent,
          child: CachedNetworkImage(
            imageUrl: poster,
            placeholder: (context, url) => CommonWidget.loading(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            fit: BoxFit.fill,
          )),
    );
  }

  static Widget buildRating(
    BuildContext context, {
    required String imdbRating,
    required String imdbVotes,
    required List<Rating> ratings,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 10, top: 20),
          child: Text(
            'Ratings',
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.grey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildTextDetail('imdbRating', imdbRating),
                  buildTextDetail('imdbVotes', imdbVotes),
                  ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: ratings.length,
                    itemBuilder: ((ctx, i) {
                      return Column(
                        children: [
                          buildTextDetail(ratings[i].source, ratings[i].value),
                        ],
                      );
                    }),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
