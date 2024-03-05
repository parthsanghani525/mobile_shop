import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/product_repository_impl.dart';
import '../../domain/usecases/add_product_usecase.dart';
import '../bloc/add_product/add_product_bloc.dart';
import '../common_component/common_editext_view.dart';

class AddProductPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AddProductBloc(
          addProductUseCase: AddProductUseCase(ProductRepositoryImpl())),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Product'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocConsumer<AddProductBloc, AddProductState>(
            builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _productImage(context), // Product image widget
                    const SizedBox(height: 25),
                    _productName(context), // Product name text field widget
                    const SizedBox(height: 16),
                    _price(context), // Price text field widget
                    const SizedBox(height: 16),
                    _category(context), // Category text field widget
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () =>
                          context.read<AddProductBloc>().add(AddProduct()),
                      child: state is AddProductLoading
                          ? const CircularProgressIndicator()
                          : const Text('Add Product'),
                    ),
                  ],
                ),
              );
            },
            listener: (BuildContext context, AddProductState state) {
              if (state is AddProductSuccess) {
                // Show snackbar on success
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Product added successfully...!'),
                  ),
                );
                // Navigate back
                Navigator.pop(context);
              }

              if (state is AddProductImage) {
                debugPrint(
                    'context.read<AddProductBloc>().imageFile:--> ${context.read<AddProductBloc>().imageFile}');
              }
            },
          ),
        ),
      ),
    );
  }

  // Widget for product name text field
  Widget _productName(BuildContext context) {
    return TextInputField(
      isPasswordField: false,
      errorText: context.watch<AddProductBloc>().errorProductName,
      hintText: 'Product Name',
      textInputType: TextInputType.text,
      onChanged: (val) {
        if (val!.isNotEmpty) {
          context.read<AddProductBloc>().setName(val);
        }
      },
    );
  }

  // Widget for price text field
  Widget _price(BuildContext context) {
    return TextInputField(
      errorText: context.watch<AddProductBloc>().errorPrice,
      hintText: 'Price',
      textInputType: TextInputType.number,
      onChanged: (val) {
        if (val!.isNotEmpty) {
          context.read<AddProductBloc>().setPrice(double.parse(val));
        }
      },
    );
  }

  // Widget for category text field
  Widget _category(BuildContext context) {
    return TextInputField(
      errorText: context.watch<AddProductBloc>().errorCategory,
      hintText: 'Category',
      textInputType: TextInputType.text,
      onChanged: (val) {
        if (val!.isNotEmpty) {
          context.read<AddProductBloc>().setCategory(val);
        }
      },
    );
  }

  // Widget for product image
  Widget _productImage(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        _openImageSelection(context); // Open image selection dialog

      },
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(100)),
        child: context.read<AddProductBloc>().imageFile != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Image.file(
                  File(context.watch<AddProductBloc>().imageFile!.path),
                  width: 150.0,
                  height: 150.0,
                  fit: BoxFit.fill,
                ),
              )
            : Container(
                decoration: BoxDecoration(color: Colors.red[200]),
                width: 150,
                height: 150,
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.grey[800],
                ),
              ),
      ),
    );
  }

  // Open image selection dialog
  _openImageSelection(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext con) {
        return BlocProvider(
          create: (cont) => context.read<AddProductBloc>(),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0)),
            ),
            child: Wrap(
              alignment: WrapAlignment.end,
              crossAxisAlignment: WrapCrossAlignment.end,
              children: [
                ListTile(
                  leading: const Icon(
                    Icons.camera,
                  ),
                  title: const Text(
                    'Camera',
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    context.read<AddProductBloc>().add(UploadProductImage(
                        imageSelectionType: ImageSource.camera));
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.image,
                  ),
                  title: const Text(
                    'Gallery',
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    context.read<AddProductBloc>().add(UploadProductImage(
                        imageSelectionType: ImageSource.gallery));
                  },
                ),
              ],
            ),
          ),
        );
      },
    );

  }
}
