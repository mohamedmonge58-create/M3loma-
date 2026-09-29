sealed class HomeState {
  const HomeState();
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);
}