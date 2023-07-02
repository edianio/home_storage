import 'package:home_storage/src/data/product/data_source/product_data_source.dart';
import 'package:home_storage/src/data/product/model/product_dto.dart';
import 'package:home_storage/src/domain/product/entities/product.dart';
import 'package:home_storage/src/domain/product/repository/product_repository.dart';
import 'package:home_storage/src/infra/either.dart';
import 'package:home_storage/src/infra/failure.dart';
import 'package:home_storage/src/infra/failure_type.dart';
import 'package:log_generator/log_generator.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductDataSource _dataSource;
  final LogGenerator _log;

  const ProductRepositoryImpl(this._dataSource, this._log);

  @override
  Future<Either<Failure, Product>> createProduct(Product product) async {
    try {
      final result = await _dataSource.createProduct(ProductDto.fromEntity(product));
      return Either(null, result.toEntity());
    } catch (e) {
      _log.error('Error creating product:\n$e');
      return const Either(Failure(FailureType.unexpected, 'Error creating product:'), null);
    }
  }

  @override
  Future<Either<Failure, void>> deleteProduct(String id) async {
    try {
      await _dataSource.deleteProduct(id);
      return const Either(null, null);
    } catch (e) {
      return const Either(Failure(FailureType.unexpected, 'Error deleting product:'), null);
    }
  }

  @override
  Future<Either<Failure, Product>> getProduct(String id) async {
    try {
      final result = await _dataSource.getProduct(id);
      return Either(null, result.toEntity());
    } catch (e) {
      return const Either(Failure(FailureType.unexpected, 'Error getting product:'), null);
    }
  }

  @override
  Stream<Either<Failure, List<Product>>> getProducts() {
    try {
      return _dataSource.getProducts().map((products) {
        return Either(null, products.map((product) => product.toEntity()).toList());
      });
    } catch (e) {
      throw Exception('Error getting products:\n$e');
    }
  }

  @override
  Future<Either<Failure, Product>> updateProduct(Product product) async {
    try {
      final result = await _dataSource.updateProduct(ProductDto.fromEntity(product));
      return Either(null, result.toEntity());
    } catch (e) {
      return const Either(Failure(FailureType.unexpected, 'Error updating product:'), null);
    }
  }
}
