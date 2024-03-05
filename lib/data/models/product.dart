/// Class representing a product in an e-commerce system
class Product {
  /// Attributes of the product
  final String name;     // Name of the product
  final double price;    // Price of the product
  final String image;    // Image URL or path of the product
  final String category; // Category of the product

  /// Constructor for creating a new Product instance
  Product({
    required this.name,
    required this.price,
    required this.image,
    required this.category,
  });

  /// Method to convert the Product object into a map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'image': image,
      'category': category,
    };
  }

  /// Factory constructor to create a Product object from a map
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['name'],          // Extract name from the map
      price: map['price'],        // Extract price from the map
      image: map['image'],        // Extract image URL/path from the map
      category: map['category'],  // Extract category from the map
    );
  }
}
