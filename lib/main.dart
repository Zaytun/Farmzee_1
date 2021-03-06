import 'package:ecommerce/providers/auth_provider.dart';
import 'package:ecommerce/screens/auth_screen.dart';
import 'package:ecommerce/screens/cart_screen.dart';
import 'package:ecommerce/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import './screens/products_overview_screen.dart';
import './screens/product_detail_screen.dart';
import 'package:provider/provider.dart';
import './providers/products.dart';
import './providers/cart.dart';
import './screens/cart_screen.dart';
import './providers/orders.dart';
import './screens/orders_screen.dart';
import './screens/user_products_screen.dart';
import './screens/edit_product_screen.dart';


Future<void>  main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final _userId = FirebaseAuth.instance?.currentUser?.uid;
    return MultiProvider(providers: [
        ChangeNotifierProvider(
        create: (ctx)=> Products(),),
      ChangeNotifierProvider(create: (_) => AuthProvider()),
      ChangeNotifierProvider(
        create: (ctx)=> Cart(),),
      ChangeNotifierProvider(
        create: (ctx)=> Orders(),),

    ],
      child: MaterialApp(
        title: 'MyShop',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
        ),

        home: _userId != null ? ProductsOverviewScreen():LoginScreen(),
        //AuthScreen(),
        //ProductsOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName: (ctx) =>  ProductDetailScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
          OrdersScreen.routeName: (ctx) => OrdersScreen(),
          UserProductsScreen.routeName:(ctx) => UserProductsScreen(),
          EditProductScreen.routeName: (ctx) => EditProductScreen(),






        },
      ),
    );
  }
}
