part of 'product_bloc.dart';

abstract class ProductEvent {}

class AddProductToCart extends ProductEvent {
  final ProductCart product;
  final String namaProduk;

  AddProductToCart({required this.namaProduk, required this.product});
}

class DeleteProductFromCart extends ProductEvent {
  final int index;
  final String namaUser;

  DeleteProductFromCart({required this.index, required this.namaUser});
}

class PlusQuantityProduct extends ProductEvent {
  final int plus;
  final String namaUser;

  PlusQuantityProduct({required this.plus, required this.namaUser});
}

class SubtractQuantityProduct extends ProductEvent {
  final int subtract;
  final String namaUser;

  SubtractQuantityProduct({required this.subtract, required this.namaUser});
}

class ClearProductEvent extends ProductEvent {}

class SaveProductEvent extends ProductEvent {}
