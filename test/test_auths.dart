
import 'package:flutter_test/flutter_test.dart';
import 'package:tbc_test/bloc/login_bloc.dart';



void main() {
   test('Test Login', () {
    final auth = GetAuthStateSuccess(success: 'done');

    expect(auth.success, 'done');
  });
}
