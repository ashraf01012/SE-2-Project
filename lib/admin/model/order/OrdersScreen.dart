import 'package:auth_module/admin/model/order/order.dart';
import 'package:auth_module/admin/model/order/order_details.dart';
import 'package:auth_module/core/repo/database_store.dart';
import 'package:auth_module/core/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrdersScreen extends StatelessWidget {
  final Store _store = Store();

  OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _store.loadOrders(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: Text('There are no orders'),
            );
          } else {
            List<OrderProduct> orders = snapshot.data!.docs.map((doc) {
              final data = doc.data() as Map<String, dynamic>;
              return OrderProduct(
                documentId: doc.id,
                address: data[kAddress] ?? '',
                totallPrice: data[kTotallPrice] != null
                    ? double.parse(data[kTotallPrice].toString())
                    : 0,
              );
            }).toList();

            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(20),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderDetails(),
                        settings: RouteSettings(arguments: orders[index]),
                      ),
                    );
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * .2,
                    color: kSecondryColor,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Total Price = \$${orders[index].totallPrice}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Address: ${orders[index].address}',
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
              ),
            );
          }
        },
      ),
    );
  }
}
