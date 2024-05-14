import 'package:auth_module/admin/model/edit/editProduct.dart';
import 'package:auth_module/core/entity_model/product_model.dart';
import 'package:auth_module/core/repo/database_store.dart';
import 'package:auth_module/core/utils/constants.dart';
import 'package:auth_module/core/utils/custom_menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ManageProducts extends StatefulWidget {
  @override
  _ManageProductsState createState() => _ManageProductsState();
}

class _ManageProductsState extends State<ManageProducts> {
  final _store = Store();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _store.loadProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No products available'));
          }

          final products = snapshot.data!.docs.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            return ProductModel(
              id: doc.id,
              price: (data[kProductPrice] is num)
                  ? (data[kProductPrice] as num).toDouble()
                  : double.tryParse(data[kProductPrice]?.toString() ?? '0') ??
                      0.0,
              pName: data[kProductName] ?? '',
              pDescription: data[kProductDescription] ?? '',
              image: data[kProductImage] ?? '',
              pCategory: data[kProductCategory] ?? '',
            );
          }).toList();

          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: .8,
            ),
            itemBuilder: (context, index) =>
                buildProductItem(context, products[index]),
            itemCount: products.length,
          );
        },
      ),
    );
  }

  Widget buildProductItem(BuildContext context, ProductModel product) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: GestureDetector(
        onTapUp: (details) async {
          double dx = details.globalPosition.dx;
          double dy = details.globalPosition.dy;
          double dx2 = MediaQuery.of(context).size.width - dx;
          double dy2 = MediaQuery.of(context).size.height - dy;
          await showMenu(
            context: context,
            position: RelativeRect.fromLTRB(dx, dy, dx2, dy2),
            items: [
              MyPopupMenuItem(
                onClick: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EditProduct(),
                      settings: RouteSettings(arguments: product),
                    ),
                  );
                },
                child: const Text('Edit'),
              ),
              MyPopupMenuItem(
                onClick: () {
                  _store.deleteProduct(product.id);
                  Navigator.pop(context);
                },
                child: const Text('Delete'),
              ),
            ],
          );
        },
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Image(
                fit: BoxFit.fill,
                image: AssetImage(
                    product.image ?? 'assets/images/placeholder.png'),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Opacity(
                opacity: .6,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          product.pName ?? 'No Name',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text('\$ ${product.price}')
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
