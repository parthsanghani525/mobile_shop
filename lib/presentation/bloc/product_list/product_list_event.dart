part of 'product_list_bloc.dart';

/// Abstract class representing events related to the product list.
@immutable
abstract class ProductListEvent {}

/// Event indicating that products need to be fetched.
class FetchProductsEvent extends ProductListEvent {}

/// Event indicating that the user should be logged out.
class LogOutUserEvent extends ProductListEvent {}
