import 'package:auth_module/core/entity_model/product_model.dart';
import 'package:auth_module/core/utils/constants.dart';
import 'package:auth_module/dashboard/model/cart/CartScreen.dart';
import 'package:auth_module/dashboard/model/cart/controller/cart_item_cubit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart' show Provider;

class ProductInfo extends StatefulWidget {
  const ProductInfo({super.key});

  @override
  _ProductInfoState createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    final ProductModel? products =
    ModalRoute.of(context)!.settings.arguments as ProductModel?;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image(
              fit: BoxFit.fill,
              image: products != null && products.image != null && products.image!.isNotEmpty
                  ? AssetImage(products.image!)
                  : AssetImage(''),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * .1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.arrow_back_ios)),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>  CartScreen(),
                          ),
                        );
                      },
                      child: const Icon(Icons.shopping_cart))
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Column(
              children: <Widget>[
                Opacity(
                  opacity: .5,
                  child: Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * .3,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            products?.pName ?? 'No Name',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            products?.pDescription ?? 'No Description',
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w800),
                          ),
                          Text(
                            '\$${products?.price}',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          // const SizedBox(
                          //   height: 10,
                          // ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              ClipOval(
                                child: Material(
                                  color: kPrimaryColor,
                                  child: GestureDetector(
                                    onTap: add,
                                    child: const SizedBox(
                                      height: 32,
                                      width: 32,
                                      child: Icon(Icons.add),
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                _quantity.toString(),
                                style: const TextStyle(fontSize: 60),
                              ),
                              ClipOval(
                                child: Material(
                                  color: kPrimaryColor,
                                  child: GestureDetector(
                                    onTap: subtract,
                                    child: const SizedBox(
                                      height: 32,
                                      width: 32,
                                      child: Icon(Icons.remove),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                ButtonTheme(
                  minWidth: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * .08,
                  child: Builder(
                    builder: (context) => MaterialButton(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              topLeft: Radius.circular(10))),
                      color: kPrimaryColor,
                      onPressed: () {
                        addToCart(context, products!);
                      },
                      child: Text(
                        'Add to Cart'.toUpperCase(),
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  subtract() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  add() {
    setState(() {
      _quantity++;
    });
  }

  void addToCart(BuildContext context, ProductModel? product) {
    if (product != null) {
      final cartItem = Provider.of<CartItemCubit>(context, listen: false);
      product.quantity = _quantity;
      bool exist = false;
      for (var productInCart in cartItem.products) {
        if (productInCart.pName == product.pName) {
          exist = true;
          break;
        }
      }
      if (exist) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('You\'ve added this item before'),
          ),
        );
      } else {
        cartItem.addProduct(product);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Added to Cart'),
          ),
        );
      }
    }
  }

}
