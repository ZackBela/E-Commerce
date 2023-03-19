import 'package:isar/isar.dart';

part 'cartItem.g.dart';

@collection
class CartItem {
  Id id = Isar.autoIncrement; // you can also use id = null to auto increment

  String? title;
  String? description;
  String? brand;
  String? category;
  String? thumbnail;
  List<String>? images;
  double? price;
  double? discountPercentage;
  double? rating;
  int? stock;
  int? quantite;
}
