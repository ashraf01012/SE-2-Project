import 'package:auth_module/auth/login_or_register.dart';
import 'package:auth_module/dashboard/model/cart/CartScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:auth_module/core/entity_model/product_model.dart';
import 'package:auth_module/core/repo/auth.dart';
import 'package:auth_module/core/repo/database_store.dart';
import 'package:auth_module/core/utils/constants.dart';
import 'package:auth_module/core/utils/function.dart';
import 'package:auth_module/dashboard/model/product/model/productInfo.dart';
import 'package:auth_module/dashboard/model/product/view/productView.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  _HomePageState createState() => _HomePageState();
  final int _quantity = 1;
}

class _HomePageState extends State<HomePage> {
  int _quantity = 1;
  final _auth = Auth();
  late User _loggedUser;
  int _tabBarIndex = 0;
  int _bottomBarIndex = 0;
  final _store = Store();
  List<ProductModel>? _products;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        DefaultTabController(
          length: 4,
          child: Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              unselectedItemColor: kUnActiveColor,
              currentIndex: _bottomBarIndex,
              fixedColor: kPrimaryColor,
              onTap: (value) async {
                if (value == 1) {
                  SharedPreferences pref =
                      await SharedPreferences.getInstance();
                  pref.clear();
                  await _auth.signOut();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginOrRegister(),
                    ),
                  );
                  Navigator.popAndPushNamed(context, 'login');
                }
                setState(() {
                  _bottomBarIndex = value;
                });
              },
              items: const [
                BottomNavigationBarItem(label: '', icon: Icon(Icons.person)),
                BottomNavigationBarItem(
                    label: 'Sign Out', icon: Icon(Icons.close)),
              ],
            ),
            appBar: AppBar(
              backgroundColor: kSecondryColor,
              elevation: 0,
              bottom: TabBar(
                indicatorColor: kPrimaryColor,
                onTap: (value) {
                  setState(() {
                    _tabBarIndex = value;
                  });
                },
                tabs: <Widget>[
                  Text(
                    'Jackets',
                    style: TextStyle(
                      color: _tabBarIndex == 0 ? Colors.black : kUnActiveColor,
                      fontSize: _tabBarIndex == 0 ? 16 : null,
                    ),
                  ),
                  Text(
                    'Trouser',
                    style: TextStyle(
                      color: _tabBarIndex == 1 ? Colors.black : kUnActiveColor,
                      fontSize: _tabBarIndex == 1 ? 16 : null,
                    ),
                  ),
                  Text(
                    'Shoes',
                    style: TextStyle(
                      color: _tabBarIndex == 2 ? Colors.black : kUnActiveColor,
                      fontSize: _tabBarIndex == 2 ? 16 : null,
                    ),
                  ),
                  Text(
                    'T-shirts',
                    style: TextStyle(
                      color: _tabBarIndex == 3 ? Colors.black : kUnActiveColor,
                      fontSize: _tabBarIndex == 3 ? 16 : null,
                    ),
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                jacketView(),
                _products != null
                    ? ProductsView(kTrousers, _products!)
                    : const CircularProgressIndicator(), // Example of guarding against null
                _products != null
                    ? ProductsView(kShoes, _products!)
                    : const CircularProgressIndicator(), // Example of guarding against null
                _products != null
                    ? ProductsView(kTShirts, _products!)
                    : const CircularProgressIndicator(), // Example of guarding against null
              ],
            ),
          ),
        ),
        Material(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * .1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Discover'.toUpperCase(),
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>  CartScreen(),
                        ),
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>  CartScreen(),
                        ),
                      );
                    },
                    child: const Icon(
                      Icons.shopping_cart,
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    getCurrenUser();
  }

  getCurrenUser() async {
    _loggedUser = (await _auth.getUser())!;
  }

  Widget jacketView() {
    return StreamBuilder<QuerySnapshot>(
      stream: _store.loadProducts(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<ProductModel> products = [];
          for (var doc in snapshot.data!.docs) {
            products.add(
              ProductModel(
                  id: doc.id,
                  price: (doc.data() != null &&
                          (doc.data() as Map<String, dynamic>)
                              .containsKey(kProductPrice))
                      ? (doc.data() as Map<String, dynamic>)[kProductPrice]
                              is int
                          ? (doc.data() as Map<String, dynamic>)[kProductPrice]!
                              .toDouble()
                          : 0
                      : 0,
                  pName:
                      (doc.data() as Map<String, dynamic>)[kProductName] ?? '',
                  pDescription: (doc.data()
                          as Map<String, dynamic>)[kProductDescription] ??
                      '',
                  image:
                      (doc.data() as Map<String, dynamic>)[kProductImage] ?? '',
                  pCategory:
                      (doc.data() as Map<String, dynamic>)[kProductCategory] ??
                          ''),
            );
          }
          _products = [...products];
          //products.clear();
          products = getProductByCategory(kJackets, _products!);
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: .8,
            ),
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProductInfo(),
                      settings: RouteSettings(arguments: products[index]),
                    ),
                  );
                },
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: Image(
                        fit: BoxFit.fill,
                        image: AssetImage(products[index].image.toString()),
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
                                horizontal: 10, vertical: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  products[index].pName.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                Text('\$ ${products[index].price}')
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            itemCount: products.length,
          );
        } else {
          return const Center(child: Text('Loading...'));
        }
      },
    );
  }
}
