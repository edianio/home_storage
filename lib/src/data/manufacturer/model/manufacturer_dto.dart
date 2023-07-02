import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:home_storage/src/domain/manufacturer/entities/manufacturer.dart';

class ManufacturerDto {
  final String? id;
  final String name;

  const ManufacturerDto({this.id, required this.name});

  factory ManufacturerDto.fromDocument(DocumentSnapshot<Map<String, dynamic>> document) {
    return ManufacturerDto(
      id: document.id,
      name: document['name'] as String,
    );
  }

  factory ManufacturerDto.fromEntity(Manufacturer manufacturer) => ManufacturerDto(
        id: manufacturer.id,
        name: manufacturer.name,
      );

  Manufacturer toEntity() => Manufacturer(
        id: id,
        name: name,
      );

  ManufacturerDto copyWith({String? id, String? name}) {
    return ManufacturerDto(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
      };
}
