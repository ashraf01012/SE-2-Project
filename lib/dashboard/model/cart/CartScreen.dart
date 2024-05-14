import 'package:auth_module/core/entity_model/product_model.dart';
import 'package:auth_module/core/repo/database_store.dart';
import 'package:auth_module/core/utils/constants.dart';
import 'package:auth_module/core/utils/custom_menu.dart';
import 'package:auth_module/dashboard/model/cart/controller/cart_item_cubit.dart';
import 'package:auth_module/dashboard/model/product/model/productInfo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<CartItemCubit>(context);
    return BlocBuilder<CartItemCubit, CartItemState>(
      builder: (context, state) {
        if (state is CartItemLoaded) {
          List<ProductModel> products = state.products;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              title: Text(
                'My Cart (${products.length})', // Display number of items in cart
                style: const TextStyle(color: Colors.black),
              ),
              leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
            ),
            body: Column(
              children: <Widget>[
                if (products.isNotEmpty)
                  Expanded(
                    child: ListView.builder(
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        return buildCartItem(context, products[index]);
                      },
                    ),
                  )
                else
                  const Expanded(
                    child: Center(
                      child: Text('Cart is Empty'),
                    ),
                  ),
                ButtonTheme(
                  minWidth: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * .08,
                  child: MaterialButton(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      showCustomDialog(products, context);
                    },
                    color: kPrimaryColor,
                    child: Text(
                      'Order'.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          // Handle other states if needed
          return Scaffold(
            appBar: AppBar(
              title: const Text('My Cart'),
            ),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  Widget buildCartItem(BuildContext context, ProductModel product) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: GestureDetector(
        onTapUp: (details) {
          showCustomMenu(details, context, product);
        },
        child: Container(
          height: 150, // Adjust height as needed
          color: kSecondryColor,
          child: Row(
            children: <Widget>[
              CircleAvatar(
                radius: 50, // Adjust radius as needed
                backgroundImage: AssetImage(
                  product.image ?? '', // Use a placeholder image if image is null
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        product.pName ?? 'No Name',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '\$${product.price?.toStringAsFixed(2) ?? '0.00'}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Text(
                'Quantity: ${product.quantity ?? 0}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showCustomMenu(details, context, product) async {
    final cubit = BlocProvider.of<CartItemCubit>(context);
    double dx = details.globalPosition.dx;
    double dy = details.globalPosition.dy;
    double dx2 = MediaQuery.of(context).size.width - dx;
    double dy2 = MediaQuery.of(context).size.width - dy;
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(dx, dy, dx2, dy2),
      items: [
        MyPopupMenuItem(
          onClick: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProductInfo(),
                settings: RouteSettings(arguments: product),
              ),
            );
            cubit.deleteProduct(product);
          },
          child: const Text('Edit'),
        ),
        MyPopupMenuItem(
          onClick: () {
            Navigator.pop(context);
            cubit.deleteProduct(product);
          },
          child: const Text('Delete'),
        ),
      ],
    );
  }

  void showCustomDialog(List<ProductModel> products, context) async {
    double price = getTotallPrice(products);
    String address = '';
    AlertDialog alertDialog = AlertDialog(
      actions: <Widget>[
        MaterialButton(
          onPressed: () {
            try {
              Store _store = Store();
              _store.storeOrders(
                {kTotallPrice: price, kAddress: address},
                products,
              );

              Navigator.pop(context);
            } catch (ex) {
              // Handle the error if needed
            }
          },
          child: const Text('Confirm'),
        ),
      ],
      content: TextField(
        onChanged: (value) {
          address = value;
        },
        decoration: const InputDecoration(hintText: 'Enter your Address'),
      ),
      title: Text('Total Price  = \$${price.toStringAsFixed(2)}'),
    );
    await showDialog(
      context: context,
      builder: (context) {
        return alertDialog;
      },
    );
  }

  double getTotallPrice(List<ProductModel> products) {
    double price = 0.0;
    for (var product in products) {
      price += (product.quantity ?? 0) * (product.price ?? 0.0);
    }
    return price;
  }
}
