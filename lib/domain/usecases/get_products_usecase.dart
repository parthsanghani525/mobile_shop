import '../../data/models/product.dart';
import '../../data/repositories/product_repository.dart';

/// Use case for getting products.
class GetProductsUseCase {
  final ProductRepository productRepository;

  /// Constructor for the use case.
  GetProductsUseCase(this.productRepository);

  /// Executes the use case by retrieving all products.
  Future<List<Product>> execute() async {
    return await productRepository.getAllProducts();
  }
}
