//import 'dart:html';
import 'package:auth_module/core/entity_model/product_model.dart';
import 'package:auth_module/core/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Store {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  addProduct(ProductModel product) {
    _firestore.collection(kProductsCollection).add({
      kProductName: product.pName,
      kProductDescription: product.pDescription,
      kProductImage: product.image,
      kProductCategory: product.pCategory,
      kProductPrice: product.price,
      kProductId: product.id,
    });
  }

  Stream<QuerySnapshot> loadProducts() {
    return _firestore.collection(kProductsCollection).snapshots();
  }

  Stream<QuerySnapshot> loadOrders() {
    return _firestore.collection(kOrders).snapshots();
  }

  Stream<QuerySnapshot> loadOrderDetails(documentId) {
    return _firestore
        .collection(kOrders)
        .doc(documentId)
        .collection(kOrderDetails)
        .snapshots();
  }

  deleteProduct(documentId) {
    _firestore.collection(kProductsCollection).doc(documentId).delete();
  }

  Future<void> editProduct(Map<String, dynamic> data, String documentId) async {
    try {
      await _firestore
          .collection(kProductsCollection)
          .doc(documentId)
          .update(data);
    } catch (e) {
      print('Error updating product: $e');
    }
  }

  storeOrders(data, List<ProductModel> products) {
    var documentRef = _firestore.collection(kOrders).doc();
    documentRef.set(data);
    for (var product in products) {
      documentRef.collection(kOrderDetails).doc().set({
        kProductName: product.pName,
        kProductPrice: product.price,
        kProductQuantity: product.quantity,
        kProductImage: product.image,
        kProductCategory: product.pCategory
      });
    }
  }
}
