import 'package:home_storage/src/domain/manufacturer/entities/manufacturer.dart';

class Product {
  final String id;
  final String name;
  final String? description;
  final double price;
  final String? image;
  final Manufacturer manufacturer;

  Product({
    required this.id,
    required this.name,
    this.description,
    required this.price,
    this.image,
    required this.manufacturer,
  });
}
