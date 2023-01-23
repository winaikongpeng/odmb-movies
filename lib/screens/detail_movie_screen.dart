// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tbc_test/bloc/common_bloc.dart';
import 'package:tbc_test/bloc/detail_movie_bloc.dart';
import 'package:tbc_test/core/widgets/common_widget.dart';
import 'package:tbc_test/core/widgets/movie_widget.dart';

class DetailMovieScreen extends StatefulWidget {
  final String imdbId;
  final String title;
  const DetailMovieScreen(
      {super.key, required this.imdbId, required this.title});

  @override
  State<DetailMovieScreen> createState() => _DetailMovieScreenState();
}

class _DetailMovieScreenState extends State<DetailMovieScreen> {
  @override
  void initState() {
    super.initState();
    context.read<DetailMovieBloc>().add(GetDetailMovieEvent(id: widget.imdbId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidget.standardAppbar(
          ctx: context, title: widget.title, showLeading: true),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<DetailMovieBloc, MainState>(
              builder: ((context, state) {
                if (state is StateLoading) {
                  return CommonWidget.loading();
                } else if (state is GetDetailMovieStateSuccess) {
                  return Column(
                    children: [
                      MovieWidgets.headderDetailMovie(
                        context,
                        poster: state.detailMovie.poster,
                        title: state.detailMovie.title,
                        year: state.detailMovie.year,
                        director: state.detailMovie.director,
                        country: state.detailMovie.country,
                        actors: state.detailMovie.actors,
                        genre: state.detailMovie.genre,
                        awards: state.detailMovie.awards,
                        language: state.detailMovie.language,
                        writer: state.detailMovie.writer,
                        production: state.detailMovie.production,
                        rated: state.detailMovie.rated,
                        boxOffice: state.detailMovie.boxOffice,
                      ),
                      MovieWidgets.buildTextDetailPlot(
                          context, state.detailMovie.plot),
                      MovieWidgets.buildRating(context,
                          imdbRating: state.detailMovie.imdbRating,
                          imdbVotes: state.detailMovie.imdbVotes,
                          ratings: state.detailMovie.ratings),
                    ],
                  );
                } else if (state is StateError) {
                  return CommonWidget.textError(
                      ctx: context, message: state.toString());
                }

                return SizedBox();
              }),
            ),
            SizedBox(
              height: 200,
            )
          ],
        ),
      ),
    );
  }
}
