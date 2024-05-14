import 'package:auth_module/core/entity_model/product_model.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'cart_item_state.dart';

class CartItemCubit extends Cubit<CartItemState> {
  CartItemCubit() : super(CartItemInitial());

  List<ProductModel> products = [];

  void addProduct(ProductModel product) {
    products.add(product);
    emit(CartItemLoaded(products)); // Emit new state
  }

  void deleteProduct(ProductModel product) {
    products.remove(product);
    emit(CartItemLoaded(products)); // Emit new state
  }
}