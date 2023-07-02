import 'package:home_storage/src/data/product/model/product_dto.dart';

abstract class ProductDataSource {
  Stream<List<ProductDto>> getProducts();
  Future<ProductDto> getProduct(String id);
  Future<ProductDto> createProduct(ProductDto product);
  Future<ProductDto> updateProduct(ProductDto product);
  Future<void> deleteProduct(String id);
}
