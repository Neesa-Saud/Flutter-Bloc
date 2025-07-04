part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

abstract class HomeActionState extends HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoadedSuccess extends HomeState {
  final List<HomeProductData> products;

  HomeLoadedSuccess({required this.products});
}

class HomeError extends HomeState {}

class HomeWishlistNavigate extends HomeActionState {}

class HomeCartNavigate extends HomeActionState {}
