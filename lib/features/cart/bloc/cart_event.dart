part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class CartInitialEvent extends CartEvent {}

class CartRemoveItemEvent extends CartEvent {}
