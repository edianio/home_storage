import 'package:home_storage/src/domain/product/entities/product.dart';
import 'package:home_storage/src/domain/product/repository/product_repository.dart';
import 'package:home_storage/src/infra/either.dart';
import 'package:home_storage/src/infra/failure.dart';

class GetProduct {
  final ProductRepository _productRepository;

  GetProduct(this._productRepository);

  Future<Either<Failure, Product>> call(String id) => _productRepository.getProduct(id);
}
