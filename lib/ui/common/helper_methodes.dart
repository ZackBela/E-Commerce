import 'package:e_commerce/local_Db/cartItem.dart';
import 'package:e_commerce/local_Db/favProduct.dart';

FavProduct convertMapProductToFavProductObject(
    Map<String, dynamic> mapProduct) {
  FavProduct product = FavProduct()
    ..code = (mapProduct['id']!).toInt()
    ..title = mapProduct['title']
    ..description = mapProduct['description']
    ..price = (mapProduct['price']!).toDouble()
    ..discountPercentage = (mapProduct['discountPercentage']!).toDouble()
    ..rating = (mapProduct['rating']!).toDouble()
    ..stock = (mapProduct['stock']!).toInt()
    ..brand = mapProduct['brand']
    ..category = mapProduct['category']
    ..thumbnail = mapProduct['thumbnail']
    ..images = [];

  return product;
}

CartItem convertMapProductToCartItemObject(
    Map<String, dynamic> mapProduct, int quantite) {
  CartItem product = CartItem()
    ..quantite = quantite
    ..title = mapProduct['title']
    ..description = mapProduct['description']
    ..price = (mapProduct['price']!).toDouble()
    ..discountPercentage = (mapProduct['discountPercentage']!).toDouble()
    ..rating = (mapProduct['rating']!).toDouble()
    ..stock = (mapProduct['stock']!).toInt()
    ..brand = mapProduct['brand']
    ..category = mapProduct['category']
    ..thumbnail = mapProduct['thumbnail']
    ..images = [];

  return product;
}

Map<String, dynamic> convertFavProductObjectToMapProduct(
    FavProduct favProduct) {
  Map<String, dynamic>? product = {};

  product['id'] = favProduct.code;
  product['title'] = favProduct.title;
  product['description'] = favProduct.description;
  product['price'] = favProduct.price;
  product['discountPercentage'] = favProduct.discountPercentage;
  product['rating'] = favProduct.rating;
  product['stock'] = favProduct.stock;
  product['brand'] = favProduct.brand;
  product['category'] = favProduct.category;
  product['thumbnail'] = favProduct.thumbnail;
  product['images'] = favProduct.images;

  return product;
}
