import 'dart:async';

import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stacked/stacked.dart';

import '../local_Db/cartItem.dart';
import '../local_Db/favProduct.dart';

class LocalDbServicesService with ListenableServiceMixin {
  LocalDbServicesService() {
    db = openDB();
  }
  Future<Isar>? db;

  final StreamController<List<CartItem>> _cartItemsController =
      StreamController<List<CartItem>>.broadcast();
  final StreamController<List<FavProduct>> _favProductsController =
      StreamController<List<FavProduct>>.broadcast();

  // Favorite Products Local Database Methodes
  Stream<List<FavProduct>> listenToFavProducts() async* {
    final isar = await db;
    yield* isar!.collection<FavProduct>().where().watch(fireImmediately: true);
  }

  Stream<List<FavProduct>> listenToAllFavProducts() {
    listenToFavProducts().listen((favProduct) {
      _favProductsController.add(favProduct);
    });

    return _favProductsController.stream;
  }

  Future<void> addNewFavoriteProduct({required FavProduct product}) async {
    final isar = await db;
    await isar!
        .writeTxn(() async => await isar.collection<FavProduct>().put(product));
  }

  Future<void> deleteFavoriteProduct({required int code}) async {
    final isar = await db;
    await isar!.writeTxn(() async => await isar
        .collection<FavProduct>()
        .filter()
        .codeEqualTo(code)
        .deleteAll());
  }

  // Cart Items Local Database Methodes
  Stream<List<CartItem>> listenToCartItems() async* {
    final isar = await db;
    yield* isar!.collection<CartItem>().where().watch(fireImmediately: true);
  }

  Stream<List<CartItem>> listenToAllCartItems() {
    listenToCartItems().listen((cartItem) {
      _cartItemsController.add(cartItem);
    });

    return _cartItemsController.stream;
  }

  Future<void> addNewCartItem({required CartItem item}) async {
    final isar = await db;
    await isar!
        .writeTxn(() async => await isar.collection<CartItem>().put(item));
  }




  Future<Isar> openDB() async {
    final dir = await getApplicationSupportDirectory();
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [
          CartItemSchema,
          FavProductSchema,
        ],
        inspector: true,
        directory: dir.path,
      );
    }

    return Future.value(Isar.getInstance());
  }
}
