import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/models/product.dart';
import '../../../domain/usecases/get_products_usecase.dart';
import '../../../domain/usecases/logout_usecase.dart';

part 'product_list_event.dart';
part 'product_list_state.dart';

/// Bloc responsible for managing the product list state and events.
class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  final GetProductsUseCase getProductsUseCase;
  final LogoutUseCase logoutUseCase;
  List<Product> products = <Product>[];

  /// Constructor for the ProductListBloc.
  ProductListBloc({
    required this.getProductsUseCase,
    required this.logoutUseCase,
  }) : super(ProductListInitial()) {
    on<FetchProductsEvent>(_fetchProductsEvent);
    on<LogOutUserEvent>(_logOutUserEvent);
  }

  /// Logic for handling the fetch products event.
  void _fetchProductsEvent(
      FetchProductsEvent event, Emitter<ProductListState> emit) async {
    products = await getProductsUseCase.execute();
    emit(ProductListLoaded());
  }

  /// Logic for handling the logout user event.
  void _logOutUserEvent(
      LogOutUserEvent event, Emitter<ProductListState> emit) async {
    await logoutUseCase.execute();
    emit(LogOutSuccess());
  }
}
