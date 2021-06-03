import 'package:flutter/material.dart';
import './product.dart';
import './db_helper.dart';


class Products with ChangeNotifier{
  List<Product> _items = [
  Product(id: 'p1', title: 'Item', description: 'very nice', price: 2.33, imageUrl: 'https://www.helpguide.org/wp-content/uploads/table-with-grains-vegetables-fruit-768.jpg'),
  Product(id: 'p2', title: 'Item1', description: 'nicer', price: 3.44, imageUrl: 'https://www.helpguide.org/wp-content/uploads/table-with-grains-vegetables-fruit-768.jpg'),
    Product(id: 'p3', title: 'Item2', description: 'interesting', price: 3.88, imageUrl: 'https://www.helpguide.org/wp-content/uploads/table-with-grains-vegetables-fruit-768.jpg'),
    Product(id: 'p4', title: 'Item3', description: 'delicious', price: 2.55, imageUrl: 'https://www.helpguide.org/wp-content/uploads/table-with-grains-vegetables-fruit-768.jpg'),
    Product(id: 'p5', title: 'Item4', description: 'enjoy your meal', price: 1.22, imageUrl: 'https://www.helpguide.org/wp-content/uploads/table-with-grains-vegetables-fruit-768.jpg'),
    Product(id: 'p6', title: 'Item5', description: 'laugh and eat', price: 7.99, imageUrl: 'https://www.helpguide.org/wp-content/uploads/table-with-grains-vegetables-fruit-768.jpg'),
    Product(id: 'p7', title: 'Item6', description: 'chop bar food or fruits?', price: 5.66, imageUrl: 'https://www.helpguide.org/wp-content/uploads/table-with-grains-vegetables-fruit-768.jpg'),
    Product(id: 'p8', title: 'Item7', description: 'enjoy your meal', price: 5.66, imageUrl: 'https://www.helpguide.org/wp-content/uploads/table-with-grains-vegetables-fruit-768.jpg'),




  ];


  var _showFavoritesOnly = false;


  List<Product> get items {
    if(_showFavoritesOnly ) {
      return _items.where((prodItem) => prodItem.isFavorite).toList();
    }
    return [..._items];
  }

  List<Product> get favoriteItems{
    return _items.where((prodItem) => prodItem.isFavorite).toList();

  }

  Product findById(String id){
    return _items.firstWhere((prod) => prod.id == id );
  }


  // void showFavoritesOnly(){
  //   _showFavoritesOnly = true;
  //   notifyListeners();
  // }
  //
  // void showAll(){
  //   _showFavoritesOnly =false;
  //   notifyListeners();
  // }


  void addProduct(Product product){
    final newProduct = Product(title: product.title, description: product.description, price: product.price, imageUrl: product.imageUrl, id: DateTime.now().toString());
    _items.add(newProduct);
    notifyListeners();
    DBHelper.insert('products', {'id': newProduct.id, 'title':newProduct.title, 'image':newProduct.imageUrl, 'description': newProduct.description, 'price': newProduct.price});
  }

  Future <void> fetchAndSetProducts() async{
    final datalist = await DBHelper.getData('products');
    datalist.map((item) => Product(id: item['id'], title: item['title'], imageUrl: item['imageUrl'], description: item['description'], price: item['price'])).toList();
  }

  void updateProduct(String id, Product newProduct){
   final prodIndex =  _items.indexWhere((prod) => prod.id == id);
   if(prodIndex >= 0){
    _items[prodIndex] = newProduct;
    notifyListeners();} else{
     print('...');
   }
  }

  void deleteProduct(String id){
    _items.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }
}