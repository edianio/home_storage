import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:home_storage/src/data/product/data_source/product_data_source.dart';
import 'package:home_storage/src/data/product/model/product_dto.dart';

class ProductDataSourceFirebase implements ProductDataSource {
  final FirebaseFirestore _firestore;

  const ProductDataSourceFirebase(this._firestore);

  @override
  Stream<List<ProductDto>> getProducts() {
    return _getCollection().snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return ProductDto.fromDocument(doc as DocumentSnapshot<Map<String, dynamic>>);
      }).toList();
    });
  }

  @override
  Future<ProductDto> createProduct(ProductDto product) async {
    final docRef = await _getCollection().add(product.toJson());
    return product.copyWith(id: docRef.id);
  }

  @override
  Future<void> deleteProduct(String id) async {
    await _getCollection().doc(id).delete();
  }

  @override
  Future<ProductDto> getProduct(String id) async {
    final doc = await _getCollection().doc(id).get();
    return ProductDto.fromDocument(doc as DocumentSnapshot<Map<String, dynamic>>);
  }

  @override
  Future<ProductDto> updateProduct(ProductDto product) async {
    final doc = await _getCollection().doc(product.id).update(product.toJson());
    return ProductDto.fromDocument(doc as DocumentSnapshot<Map<String, dynamic>>);
  }

  CollectionReference _getCollection() {
    return _firestore.collection('home_storage/products');
  }
}
