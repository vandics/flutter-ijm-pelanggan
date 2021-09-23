part of 'product_bloc.dart';

class ProductState {
  List<ProductCart> products = [];
  final double total;
  final double price;
  final int amount;
  final double delivery;
  List id;
  final int sumAmount;

  ProductState(
      {required this.products,
      this.sumAmount = 0,
      required this.id,
      this.price = 0,
      this.total = 0.0,
      this.amount = 0,
      this.delivery = 6500});

  ProductState copyWith(
          {required List<ProductCart> products,
          required double total,
          int amount = 0,
          double? delivery,
          int sumAmount = 0,
          required double price,
          required List id}) =>
      ProductState(
          products: products,
          total: total,
          price: price,
          amount: amount,
          sumAmount: sumAmount,
          id: id);
}
