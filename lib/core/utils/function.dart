import 'package:auth_module/core/entity_model/product_model.dart';

List<ProductModel> getProductByCategory(
    String kJackets, List<ProductModel> allproducts) {
  List<ProductModel> products = [];
  try {
    for (var product in allproducts) {
      if (product.pCategory == kJackets) {
        products.add(product);
      }
    }
  } on Error catch (ex) {}
  return products;
}
