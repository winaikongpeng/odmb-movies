import 'dart:convert';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tbc_test/bloc/common_bloc.dart';
import 'package:tbc_test/core/api_base.dart';
import 'package:tbc_test/models/search.dart';
import 'package:http/http.dart' as http;

class SearchBloc extends Bloc<MainEvent, MainState> {
  SearchBloc() : super(StateInitialzed()) {
    on<GetSearchEvent>(_onGetSearch);
  }

  void _onGetSearch(GetSearchEvent event, Emitter<MainState> emit) async {
    emit(StateLoading());
    try {
      final res = await http.get(ApiBase.getUriSearch(event.input));
      if (res.statusCode != HttpStatus.ok) {
        emit(StateError(message: res.body));
        return;
      }
      final checkResult = Map.from(jsonDecode(res.body));

      if (checkResult['Response'] == 'False') {
        emit(GetSearchStateNotFind(message: checkResult['Error'].toString()));
      } else {
        final searchs = Search.fromJson(jsonDecode(res.body));
        emit(GetSearchStateSuccess(searchs: searchs));
      }
    } on Exception {
      emit(StateError(message: 'something went wrong'));
    } catch (e) {
      emit(StateError(message: e.toString()));
    }
  }
}

class GetSearchEvent extends MainEvent {
  final String input;

  GetSearchEvent({required this.input});
}

class GetSearchStateSuccess extends MainState {
  Search searchs;
  GetSearchStateSuccess({required this.searchs});
}

class GetSearchStateNotFind extends MainState {
  final String message;
  GetSearchStateNotFind({required this.message});
  @override
  String toString() => message.toString();
}
