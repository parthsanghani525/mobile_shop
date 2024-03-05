import '../../data/models/product.dart';
import '../../data/repositories/product_repository.dart';

/// Use case for adding a product.
class AddProductUseCase {
  final ProductRepository productRepository;

  /// Constructor for the use case.
  AddProductUseCase(this.productRepository);

  /// Executes the use case by adding the provided product.
  Future<void> execute(Product product) async {
    await productRepository.addProduct(product);
  }
}
