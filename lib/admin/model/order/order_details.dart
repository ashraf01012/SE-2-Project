import 'package:auth_module/admin/model/order/order.dart';
import 'package:auth_module/core/entity_model/product_model.dart';
import 'package:auth_module/core/repo/database_store.dart';
import 'package:auth_module/core/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderDetails extends StatelessWidget {
  final Store store = Store();

  OrderDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderProduct? orders =
        ModalRoute.of(context)!.settings.arguments as OrderProduct?;

    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: store.loadOrderDetails(orders!.documentId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            List<ProductModel> products = snapshot.data!.docs.map((doc) {
              final data = doc.data() as Map<String, dynamic>;
              return ProductModel(
                pName: data[kProductName] ?? '',
                quantity: data[kProductQuantity] ?? 0,
                pCategory: data[kProductCategory] ?? '',
                price: (data[kProductPrice] as num?)?.toDouble() ?? 0.0,
              );
            }).toList();

            return Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(20),
                      child: Container(
                        height: MediaQuery.of(context).size.height * .3,
                        color: kSecondryColor,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Product name : ${products[index].pName}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Quantity : ${products[index].quantity}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Price :\$${products[index].price}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Total Price : \$${((products[index].price ?? 0) * (products[index].quantity ?? 0))}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Product Category : ${products[index].pCategory}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    itemCount: products.length,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: ButtonTheme(
                          buttonColor: kPrimaryColor,
                          child: MaterialButton(
                            onPressed: () {
                              // Implement Confirm Order action
                            },
                            child: const Text('Confirm Order'),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ButtonTheme(
                          buttonColor: kPrimaryColor,
                          child: MaterialButton(
                            onPressed: () {
                              // Implement Delete Order action
                            },
                            child: const Text('Delete Order'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: Text('Loading Order Details'),
            );
          }
        },
      ),
    );
  }
}
