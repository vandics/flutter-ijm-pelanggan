import 'package:equatable/equatable.dart';

class ProductCart extends Equatable {
  final String? namaProduk;
  final double price;
  int amount;
  String id;

  ProductCart(
      {required this.namaProduk,
      required this.price,
      required this.amount,
      required this.id});

  Map<String?, dynamic> toJson() {
    return {
      'nama': namaProduk,
      'price': price,
      'amount': amount,
      'id': id,
    };
  }

  @override
  List<Object?> get props => [namaProduk, price, amount, id];
}
