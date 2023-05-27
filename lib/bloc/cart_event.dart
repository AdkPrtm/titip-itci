part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class AddToCart extends CartEvent {
  final ResiModel resiModel;
  AddToCart({required this.resiModel});
}

class DeleteResiFromCart extends CartEvent {
  final ResiModel resiModel;
  DeleteResiFromCart({required this.resiModel});
}

class ClearCart extends CartEvent {}
