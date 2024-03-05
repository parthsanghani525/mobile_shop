part of 'product_list_bloc.dart';

/// Abstract class representing states related to the product list.
@immutable
abstract class ProductListState {}

/// Initial state when the product list starts.
class ProductListInitial extends ProductListState {}

/// State indicating that the product list is being loaded.
class ProductListLoading extends ProductListState {}

/// State indicating that the product list has been successfully loaded.
class ProductListLoaded extends ProductListState {}

/// State indicating that an error occurred while loading the product list.
class ProductListError extends ProductListState {}

/// State indicating that the user has been successfully logged out.
class LogOutSuccess extends ProductListState {}
