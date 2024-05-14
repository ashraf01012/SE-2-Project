
import 'package:flutter/material.dart';
const kPrimaryColor =Color(0xFFB0BEC5);
const kSecondryColor =Color(0xFF78909C);
const kUnActiveColor = Color(0xFFC1BDB8);
const kProductsCollection ='product';
const kProductName = 'productName';
const kProductPrice = 'productPrice';
const kProductId = 'productPId';
const kProductDescription = 'productDescription';
const kProductImage = 'productImage';
const kProductCategory = 'productCategory';
const kJackets = 'kJackets';
const kTrousers = 'trousers';
const kTShirts = 'shirts';
const kShoes = 'shoes';
const kOrders = 'Orders';
const kOrderDetails = 'OrderDetails';
const kTotallPrice = 'TotallPrice';
const kAddress = 'Address';
const kProductQuantity = 'Quantity';
const kKeepMeLoggedIn = 'KeepMeLoggedIn';
final double appBarHeight = AppBar().preferredSize.height;
const  decoration =  InputDecoration(
  labelStyle: TextStyle(
    color: Colors.black,
  ),
  border: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.black,
      width: 1,
    ),
    borderRadius: BorderRadius.all(Radius.circular(20)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.black,
      width: 1,
    ),
    borderRadius: BorderRadius.all(Radius.circular(20)),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.red,
      width: 1,
    ),
    borderRadius: BorderRadius.all(
      Radius.circular(20),
    ),
  ),
);
