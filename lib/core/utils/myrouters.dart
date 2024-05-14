// import 'package:flutter/material.dart';
// import 'package:untitled/features/auth/admin/model/addproduct/view/add_product_page.dart';
// import 'package:untitled/features/auth/admin/model/edit/editProduct.dart';
// import 'package:untitled/features/auth/admin/model/manageproducts/ManageProducts.dart';
// import 'package:untitled/features/auth/admin/model/order/OrdersScreen.dart';
// import 'package:untitled/features/auth/admin/model/order/order_details.dart';
// import 'package:untitled/features/auth/admin/view/page/admin_page.dart';
// import 'package:untitled/features/auth/dashboard/model/cart/CartScreen.dart';
// import 'package:untitled/features/auth/dashboard/model/product/model/productInfo.dart';
// import 'package:untitled/features/auth/forget/view/page/forget_page.dart';
// import 'package:untitled/features/auth/dashboard/view/page/dashboard_page.dart';
// import 'package:untitled/features/auth/login/view/page/login_page.dart';
// import 'package:untitled/features/auth/onboarding/view/page/onboarding_page.dart';
// import 'package:untitled/features/auth/registration/view/page/registration_page.dart';

// class MyRoutes {
//   static List<Route> initRoutes = [
//     MaterialPageRoute<dynamic>(
//       builder: (BuildContext context) => const LogInPage(),
//     ),
//   ];
//   static Route<dynamic> onGenerateRoute(RouteSettings settings) {
//     switch (settings.name) {
//       case 'login':
//       // final List data = settings.arguments as List;
//         return MaterialPageRoute<dynamic>(
//           builder: (BuildContext context) => const LogInPage(),
//         );
//       case 'registration':
//         return MaterialPageRoute<dynamic>(
//           builder: (BuildContext context) => const RegistrationPage(),
//         );
//       case 'home':
//         return MaterialPageRoute<dynamic>(
//           builder: (BuildContext context) =>  const HomePage(),
//         );
//       case 'forget':
//         return MaterialPageRoute<dynamic>(
//           builder: (BuildContext context) => const ForgetPage(),
//         );
//       case 'admin':
//         return MaterialPageRoute<dynamic>(
//           builder: (BuildContext context) => const AdminPage(),
//         );
//       case 'NewProductPage':
//         return MaterialPageRoute<dynamic>(
//           builder: (BuildContext context) => const NewProductPage(),
//         );
//       case 'edit':
//         return MaterialPageRoute<dynamic>(
//           builder: (BuildContext context) => const EditProduct(),
//         );
//       case 'manage':
//         return MaterialPageRoute<dynamic>(
//           builder: (BuildContext context) => ManageProducts(),
//         );
//       case 'OrdersScreen':
//         return MaterialPageRoute<dynamic>(
//           builder: (BuildContext context) => OrdersScreen(),
//         );
//         case 'CartScreen':
//         return MaterialPageRoute<dynamic>(
//           builder: (BuildContext context) => CartScreen(),
//         );
//         case 'ProductInfo':
//         return MaterialPageRoute<dynamic>(
//           builder: (BuildContext context) => const ProductInfo(),
//         );
//         case 'OrderDetails':
//         return MaterialPageRoute<dynamic>(
//           builder: (BuildContext context) => OrderDetails(),
//         );
//       default:
//         return MaterialPageRoute<dynamic>(
//           builder: (BuildContext context) => const OnboardingPage(),
//         );
//     }
//   }
// }