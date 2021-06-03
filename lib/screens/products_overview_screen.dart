import 'package:flutter/material.dart';
import '../widgets/products_grid.dart';
import '../widgets/badge.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';
import '../screens/cart_screen.dart';
import '../widgets/app_drawer.dart';
import '../providers/products.dart';

enum FilterOptions{
  Favorites,
  All
}

class ProductsOverviewScreen extends StatefulWidget {



  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {

 var _showOnlyFavorites = false;
  @override
  Widget build(BuildContext context) {
    final cart =Provider.of<Cart>(context);


    return Scaffold(
      appBar: AppBar(title: Text('MyShop'),
      actions: <Widget>[
        PopupMenuButton(
          onSelected: (FilterOptions selectedValue){

            setState(() {
              if(selectedValue == FilterOptions.Favorites){
                _showOnlyFavorites =true;

              } else{
                _showOnlyFavorites= false;
              }

            });

          },
          icon: Icon(Icons.more_vert,), itemBuilder: (_) =>[
          PopupMenuItem(child: Text('Only Favorites'), value:FilterOptions.Favorites),
          PopupMenuItem(child: Text('Show All'),value:FilterOptions.All),  ] ,),
         Consumer<Cart>(builder: (_, cartData, ch ) => Badge(
           child: ch,
           value: cart.itemCount.toString(),
         ),
           child: IconButton(
             icon: Icon(
               Icons.shopping_cart,
             ),
             onPressed: (){Navigator.of(context).pushNamed(CartScreen.routeName);
             },
           ),
           ),
      ],
       ),

      drawer: AppDrawer(),


      body:ProductsGrid(_showOnlyFavorites),

    );
  }
}

