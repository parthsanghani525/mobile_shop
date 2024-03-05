part of 'add_product_bloc.dart';

/// Abstract class representing events related to adding a product.
@immutable
abstract class AddProductEvent {}

/// Event indicating that a product is to be added.
class AddProduct extends AddProductEvent {}

/// Event for uploading a product image.
class UploadProductImage extends AddProductEvent {
  final ImageSource imageSelectionType;

  UploadProductImage({required this.imageSelectionType});
}
