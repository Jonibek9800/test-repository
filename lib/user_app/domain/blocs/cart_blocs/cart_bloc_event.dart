
import '../../../../entity/check.dart';
import '../../../../entity/product.dart';

abstract class CartBlocEvent {}

class InitCartEvent extends CartBlocEvent {}

class AddCartEvent extends CartBlocEvent {
  Product? product;

  AddCartEvent({required this.product});
}

class RemoveFromCartEvent extends CartBlocEvent {
  Product? product;

  RemoveFromCartEvent({required this.product});
}

class ErrorCartEvent extends CartBlocEvent {}

class GetProductsByIdEvent extends CartBlocEvent {}

class AddQuantityEvent extends CartBlocEvent {
  Product? product;

  AddQuantityEvent({required this.product});
}

class RemoveQuantityEvent extends CartBlocEvent {
  Product? product;

  RemoveQuantityEvent({required this.product});
}

class AddedInCartEvent extends CartBlocEvent {}

class OrderByCartEvent extends CartBlocEvent {
  int? userId;

  OrderByCartEvent({
    required this.userId,
  });
}

class ChecksByOrderEvent extends CartBlocEvent {
  int? userId;

  ChecksByOrderEvent({required this.userId});
}

class CheckDetailsByOrderEvent extends CartBlocEvent {
  Check? details;

  CheckDetailsByOrderEvent({required this.details});
}
