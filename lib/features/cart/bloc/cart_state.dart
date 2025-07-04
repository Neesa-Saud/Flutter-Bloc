part of 'cart_bloc.dart';

@immutable
abstract class CartState {}

abstract class CartActionState extends CartState {}

class CartInitial extends CartState {}

class CartSuccess extends CartState {
  final List<HomeProductData> cartItems;
  CartSuccess({required this.cartItems});
}
