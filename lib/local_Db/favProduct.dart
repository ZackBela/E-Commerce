import 'package:isar/isar.dart';

part 'favProduct.g.dart';

@collection
class FavProduct {
  Id id = Isar.autoIncrement; // you can also use id = null to auto increment
  int? code;
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
}
