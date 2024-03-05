import '../models/product.dart';

/// An abstract class defining the interface for interacting with products in a repository.
abstract class ProductRepository {
  /// Asynchronously adds a product to the repository.
  Future<void> addProduct(Product product);

  /// Asynchronously retrieves all products from the repository.
  Future<List<Product>> getAllProducts();
}
