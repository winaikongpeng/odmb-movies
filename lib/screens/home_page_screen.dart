// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tbc_test/bloc/common_bloc.dart';
import 'package:tbc_test/core/widgets/common_widget.dart';
import 'package:tbc_test/core/widgets/movie_widget.dart';
import '../bloc/search_bloc.dart';
import 'detail_movie_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final key = GlobalKey<FormState>();
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidget.standardAppbar(
          ctx: context, title: 'OMDb Movies', showLeading: false),
      body: SingleChildScrollView(
        child: Column(
          children: [
            sizedBoxHeight(),
            buildRowSearchWidget(context),
            sizedBoxHeight(),
            BlocBuilder<SearchBloc, MainState>(
              builder: (context, state) {
                if (state is StateLoading) {
                  return CommonWidget.loading();
                } else if (state is GetSearchStateSuccess) {
                  return ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: state.searchs.search.length,
                    itemBuilder: (ctx, i) {
                      return MovieWidgets.cardMovieWidget(
                          state.searchs.search[i].poster,
                          state.searchs.search[i].title,
                          state.searchs.search[i].year,
                          state.searchs.search[i].type, () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: ((context) => DetailMovieScreen(
                                  imdbId: state.searchs.search[i].imdbId,
                                  title: state.searchs.search[i].title,
                                )),
                          ),
                        );
                      });
                    },
                  );
                } else if (state is StateError) {
                  return CommonWidget.textError(
                      ctx: context, message: state.toString());
                } else if (state is GetSearchStateNotFind) {
                  return CommonWidget.textNotFind(
                      ctx: context, message: state.toString());
                }
                return SizedBox();
              },
            ),
            SizedBox(
              height: 200,
            )
          ],
        ),
      ),
    );
  }

  SizedBox sizedBoxHeight() {
    return SizedBox(
      height: 30,
    );
  }

  Widget buildRowSearchWidget(BuildContext context) {
    return Form(
      key: key,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: CommonWidget.textFormfieldStandard(
              label: 'search movies',
              controller: searchController,
              validator: ((value) {
                value ??= '';
                if (value.isEmpty) return 'Plaese enter your title';
                return null;
              }),
            ),
          ),
          const SizedBox(
            width: 40,
          ),
          CommonWidget.standardButton(
              context: context,
              title: 'search',
              onPressed: () {
                if (!(key.currentState?.validate() ?? false)) {
                  return;
                } else {
                  context
                      .read<SearchBloc>()
                      .add(GetSearchEvent(input: searchController.text));
                }
              }),
        ],
      ),
    );
  }
}
