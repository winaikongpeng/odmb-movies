abstract class MainEvent {}

abstract class MainState {}

class StateInitialzed extends MainState {}

class StateLoading extends MainState {
  @override
  String toString() => 'Loading';
}

class StateError extends MainState {
  final String message;
  StateError({required this.message});
  @override
  String toString() => message;
}
