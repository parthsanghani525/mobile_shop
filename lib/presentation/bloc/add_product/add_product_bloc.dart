import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/models/product.dart';
import '../../../domain/usecases/add_product_usecase.dart';

part 'add_product_event.dart';
part 'add_product_state.dart';

/// Bloc responsible for handling the logic related to adding a product.
class AddProductBloc extends Bloc<AddProductEvent, AddProductState> {
  final AddProductUseCase addProductUseCase;

  ImagePicker imagePicker = ImagePicker();

  String name = '';
  double price = 0.0;
  String category = '';
  XFile? imageFile;

  String errorProductName = '';
  String errorPrice = '';
  String errorCategory = '';

  /// Constructor for the AddProductBloc.
  AddProductBloc({required this.addProductUseCase})
      : super(AddProductInitial()) {
    on<AddProduct>(_addProduct);
    on<UploadProductImage>(_uploadImage);
  }

  /// Setter methods for updating the values.
  void setName(String value) => name = value;

  void setPrice(double value) => price = value;

  void setCategory(String value) => category = value;

  void setErrorProductName(String value) => errorProductName = value;

  void setErrorPrice(String value) => errorPrice = value;

  void setErrorCategory(String value) => errorCategory = value;

  /// Logic for adding a product.
  void _addProduct(AddProduct event, Emitter<AddProductState> emit) async {
    debugPrint('values:--> $name $price $category');
    if (name.isEmpty) {
      setErrorProductName('Enter product name');
      emit(AddProductError());
    } else if (price == 0.0) {
      setErrorProductName('');
      setErrorPrice('Enter product price');
      emit(AddProductError());
    } else if (category.isEmpty) {
      setErrorProductName('');
      setErrorPrice('');
      setErrorCategory('Enter product category');
      emit(AddProductError());
    } else {
      setErrorProductName('');
      setErrorPrice('');
      setErrorCategory('');
      emit(AddProductLoading());
      final product = Product(
        name: name,
        price: price,
        image: imageFile != null ? imageFile!.path : '',
        category: category,
      );
      await addProductUseCase.execute(product);
      imageFile = null;
      emit(AddProductSuccess());
    }
  }

  /// Logic for uploading a product image.
  Future<void> _uploadImage(
      UploadProductImage event, Emitter<AddProductState> emit) async {
    final pickedImage =
    await ImagePicker().pickImage(source: event.imageSelectionType);
    if (pickedImage != null) {
      imageFile = XFile(pickedImage.path);
    }
    emit(AddProductImage());
  }
}
