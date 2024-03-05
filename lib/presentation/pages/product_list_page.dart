import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_store/presentation/bloc/product_list/product_list_bloc.dart';
import 'package:mobile_store/presentation/pages/add_product_page.dart';
import 'package:mobile_store/presentation/pages/login_page.dart';

import '../../domain/repositories/product_repository_impl.dart';
import '../../domain/repositories/user_repository_impl.dart';
import '../../domain/usecases/get_products_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';

class ProductListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      /// Provide ProductListBloc to the widget tree
      create: (BuildContext context) => ProductListBloc(
          getProductsUseCase: GetProductsUseCase(ProductRepositoryImpl()),
          logoutUseCase: LogoutUseCase(UserRepositoryImpl()))
        ..add(FetchProductsEvent()),

      /// Fetch products on page load
      child: BlocBuilder<ProductListBloc, ProductListState>(
  builder: (context, state) {
    return Scaffold(
        appBar: AppBar(title: const Text('Product List'), actions: [
          /// Logout button in the app bar
          GestureDetector(
              onTap: () {
                showAlertDialog(
                  context,
                );
              },
              child: const Icon(Icons.logout)),
          const SizedBox(
            width: 10,
          )
        ]),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddProductPage(),
                    ))
                .then((value) =>
                    context.read<ProductListBloc>().add(FetchProductsEvent()));
          },
          child: const Icon(Icons.add),

          /// Add product button
        ),
        body: Padding(
          padding:
          const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          child: ListView.separated(
            itemCount: context.watch<ProductListBloc>().products.length,
            itemBuilder: (context, index) {
              final product =
              context.watch<ProductListBloc>().products[index];
              return Container(
                /// Container for each product item
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black, width: 1.0),
                    borderRadius:
                    const BorderRadius.all(Radius.circular(10.0)),
                    boxShadow: const [
                      BoxShadow(
                          blurRadius: 5,
                          color: Colors.black38,
                          offset: Offset(1, 3))
                    ]),
                padding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Row(
                  children: [
                    /// Product image
                    SizedBox(
                      height: 50,
                      width: 50,
                      child: product.image.isNotEmpty
                          ? ClipRRect(
                        borderRadius:
                        const BorderRadius.all(Radius.circular(50)),
                        child: Image.file(
                          File(product.image),
                          width: 50.0,
                          height: 50.0,
                          fit: BoxFit.fill,
                        ),
                      )
                          : ClipRRect(
                        borderRadius:
                        const BorderRadius.all(Radius.circular(50)),
                        child: Container(
                          decoration:
                          BoxDecoration(color: Colors.red[200]),
                          width: 50,
                          height: 50,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        title: Row(
                          children: [
                            Text('Name: ${product.name}'),
                          ],
                        ),
                        subtitle: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Price: ${product.price}'),
                                Text('Category: ${product.category}'),
                              ],
                            ),
                          ],
                        ),
                        onTap: () => null,

                        /// Add functionality to view product details
                      ),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                height: 10,
              );
            },
          ),
        ),
      );
  },
),
    );
  }

  /// Show logout confirmation dialog
  void showAlertDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return BlocProvider(
            create: (BuildContext context) => ProductListBloc(
                getProductsUseCase: GetProductsUseCase(ProductRepositoryImpl()),
                logoutUseCase: LogoutUseCase(UserRepositoryImpl())),
            child: BlocConsumer<ProductListBloc, ProductListState>(
              listener: (context, state) {
                if (state is LogOutSuccess) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ));

                  /// Navigate to login page on logout
                }
              },
              builder: (context, state) {
                return AlertDialog(
                  title: const Text('Alert'),
                  content: Text('Are you sure want to logout...'),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('No'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    TextButton(
                      child: const Text('Yes'),
                      onPressed: () {
                        Navigator.pop(context);
                        context.read<ProductListBloc>().add(LogOutUserEvent());

                        /// Logout user
                      },
                    ),
                  ],
                );
              },
            ),
          );
        });
  }
}
