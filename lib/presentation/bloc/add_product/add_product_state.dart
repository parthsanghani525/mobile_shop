part of 'add_product_bloc.dart';

/// Abstract class representing states related to adding a product.
@immutable
abstract class AddProductState {}

/// Initial state when adding a product.
class AddProductInitial extends AddProductState {}

/// State indicating that adding a product is in progress.
class AddProductLoading extends AddProductState {}

/// State indicating that adding a product was successful.
class AddProductSuccess extends AddProductState {}

/// State indicating that an error occurred while adding a product.
class AddProductError extends AddProductState {}

/// State indicating that an image for the product is uploaded.
class AddProductImage extends AddProductState {}
