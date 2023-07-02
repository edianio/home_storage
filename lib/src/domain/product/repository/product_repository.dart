import 'package:home_storage/src/domain/product/entities/product.dart';
import 'package:home_storage/src/infra/either.dart';
import 'package:home_storage/src/infra/failure.dart';

abstract class ProductRepository {
  Stream<Either<Failure, List<Product>>> getProducts();
  Future<Either<Failure, Product>> getProduct(String id);
  Future<Either<Failure, Product>> createProduct(Product product);
  Future<Either<Failure, Product>> updateProduct(Product product);
  Future<Either<Failure, void>> deleteProduct(String id);
}
