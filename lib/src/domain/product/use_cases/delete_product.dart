import 'package:home_storage/src/domain/product/repository/product_repository.dart';
import 'package:home_storage/src/infra/either.dart';
import 'package:home_storage/src/infra/failure.dart';

class DeleteProduct {
  final ProductRepository _productRepository;

  DeleteProduct(this._productRepository);

  Future<Either<Failure, void>> call(String id) => _productRepository.deleteProduct(id);
}
