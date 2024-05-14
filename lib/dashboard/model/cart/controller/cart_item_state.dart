part of 'cart_item_cubit.dart';

@immutable
sealed class CartItemState {}
class CartItemInitial extends CartItemState {}
class CartItemLoaded extends CartItemState {
  final List<ProductModel> products;

  CartItemLoaded(this.products);
}
