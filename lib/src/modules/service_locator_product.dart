import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:home_storage/src/data/product/data_source/product_data_source.dart';
import 'package:home_storage/src/data/product/repository/product_repository_impl.dart';
import 'package:home_storage/src/domain/product/repository/product_repository.dart';
import 'package:home_storage/src/domain/product/use_cases/create_product.dart';
import 'package:home_storage/src/domain/product/use_cases/delete_product.dart';
import 'package:home_storage/src/domain/product/use_cases/get_product.dart';
import 'package:home_storage/src/domain/product/use_cases/get_products.dart';
import 'package:home_storage/src/domain/product/use_cases/update_product.dart';
import 'package:home_storage/src/external/product/product_data_source_firebase.dart';
import 'package:home_storage/src/modules/service_locator_setup.dart';
import 'package:log_generator/log_generator.dart';

void serviceLocatorProduct() {
  // DATA SOURCE
  getIt.registerLazySingleton<ProductDataSource>(() => ProductDataSourceFirebase(getIt<FirebaseFirestore>()));
  // REPOSITORY
  getIt.registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl(
        getIt<ProductDataSource>(),
        getIt<LogGenerator>(),
      ));
  // USE CASES
  getIt.registerLazySingleton<UpdateProduct>(() => UpdateProduct(getIt<ProductRepository>()));
  getIt.registerLazySingleton<CreateProduct>(() => CreateProduct(getIt<ProductRepository>()));
  getIt.registerLazySingleton<DeleteProduct>(() => DeleteProduct(getIt<ProductRepository>()));
  getIt.registerLazySingleton<GetProduct>(() => GetProduct(getIt<ProductRepository>()));
  getIt.registerLazySingleton<GetProducts>(() => GetProducts(getIt<ProductRepository>()));
}
