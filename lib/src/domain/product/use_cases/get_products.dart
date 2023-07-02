import 'package:home_storage/src/domain/product/entities/product.dart';
import 'package:home_storage/src/domain/product/repository/product_repository.dart';
import 'package:home_storage/src/infra/either.dart';
import 'package:home_storage/src/infra/failure.dart';

class GetProducts {
  final ProductRepository _productRepository;

  GetProducts(this._productRepository);

  Stream<Either<Failure, List<Product>>> call() => _productRepository.getProducts();
}
