import 'package:home_storage/src/domain/product/entities/product.dart';
import 'package:home_storage/src/domain/product/repository/product_repository.dart';
import 'package:home_storage/src/infra/either.dart';
import 'package:home_storage/src/infra/failure.dart';

class UpdateProduct {
  final ProductRepository _productRepository;

  UpdateProduct(this._productRepository);

  Future<Either<Failure, Product>> call(Product product) => _productRepository.updateProduct(product);
}
