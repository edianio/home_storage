import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:home_storage/src/data/manufacturer/model/manufacturer_dto.dart';
import 'package:home_storage/src/domain/product/entities/product.dart';

class ProductDto {
  final String id;
  final String name;
  final String? description;
  final double price;
  final String? image;
  final ManufacturerDto manufacturer;

  ProductDto({
    required this.id,
    required this.name,
    this.description,
    required this.price,
    this.image,
    required this.manufacturer,
  });

  factory ProductDto.fromDocument(DocumentSnapshot<Map<String, dynamic>> doc) => ProductDto(
        id: doc.id,
        name: doc['name'] as String,
        description: doc['description'] as String?,
        price: doc['price'] as double,
        image: doc['image'] as String?,
        manufacturer: ManufacturerDto.fromDocument(doc['manufacturer'] as DocumentSnapshot<Map<String, dynamic>>),
      );

  factory ProductDto.fromEntity(Product product) => ProductDto(
        id: product.id,
        name: product.name,
        description: product.description,
        price: product.price,
        image: product.image,
        manufacturer: ManufacturerDto.fromEntity(product.manufacturer),
      );

  Map<String, dynamic> toJson() => {
        //'id': id,// No need to send id to firebase
        'name': name,
        'description': description,
        'price': price,
        'image': image,
        'manufacturer': manufacturer.toJson(),
      };

  ProductDto copyWith({String? id, String? name, String? description, double? price, String? image, ManufacturerDto? manufacturer}) =>
      ProductDto(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        price: price ?? this.price,
        image: image ?? this.image,
        manufacturer: manufacturer ?? this.manufacturer,
      );

  Product toEntity() => Product(
        id: id,
        name: name,
        description: description,
        price: price,
        image: image,
        manufacturer: manufacturer.toEntity(),
      );
}
