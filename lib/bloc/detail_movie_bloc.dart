import 'dart:convert';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tbc_test/bloc/common_bloc.dart';
import 'package:tbc_test/core/api_base.dart';
import 'package:tbc_test/models/detail_movie.dart';
import 'package:http/http.dart' as http;

class DetailMovieBloc extends Bloc<MainEvent, MainState> {
  DetailMovieBloc() : super(StateInitialzed()) {
    on<GetDetailMovieEvent>(_onGetDetailMovie);
  }

  void _onGetDetailMovie(
      GetDetailMovieEvent event, Emitter<MainState> emit) async {
    emit(StateLoading());
    try {
      final res = await http.get(ApiBase.getUriDetailMovie(event.id));
      if (res.statusCode != HttpStatus.ok) {
        emit(StateError(message: res.body));
        return;
      }
      final detailMovie = DetailMovie.fromJson(jsonDecode(res.body));
      emit(GetDetailMovieStateSuccess(detailMovie: detailMovie));
    } on Exception {
      emit(StateError(message: 'something went wrong'));
    } catch (e) {
      emit(StateError(message: e.toString()));
    }
  }
}

class GetDetailMovieEvent extends MainEvent {
  final String id;
  GetDetailMovieEvent({required this.id});
}

class GetDetailMovieStateSuccess extends MainState {
  DetailMovie detailMovie;
  GetDetailMovieStateSuccess({required this.detailMovie});
}
