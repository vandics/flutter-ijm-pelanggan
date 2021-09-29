import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app_ijm_pelanggan/controller/imagecontroller.dart';
import 'package:mobile_app_ijm_pelanggan/models/productmodels.dart';

part 'product_state.dart';
part 'product_event.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductState(products: [], id: []));

  List<ProductCart> product = [];
  List id = [];

  @override
  Stream<ProductState> mapEventToState(ProductEvent event) async* {
    if (event is AddProductToCart) {
      {
        product.removeWhere(
            (element) => element.namaProduk == event.product.namaProduk);
        product.add(event.product);
        double sum = 0;
        double pricee = 0;
        int sumAmount = 0;
        product.removeWhere((element) => element.amount == 0);
        id.add(event.product.id);
        product.forEach((element) {
          sum = sum + (element.price * element.amount);
          pricee = element.price;
          sumAmount = sumAmount + element.amount;
        });

        yield state.copyWith(
          price: pricee,
          products: product,
          total: sum,
          amount: product.length,
          id: id,
          sumAmount: sumAmount,
        );
      }
    } else if (event is PlusQuantityProduct) {
      product[event.plus].amount++;

      double total = 0;
      double pricee = 0;
      int sumAmount = 0;

      product.forEach((element) {
        total = total + (element.price * element.amount);
        pricee = element.price;
        sumAmount = sumAmount + element.amount;
      });
      yield state.copyWith(
        products: product,
        total: total,
        price: pricee,
        id: id,
        sumAmount: sumAmount,
      );
    } else if (event is SubtractQuantityProduct) {
      product[event.subtract].amount--;

      if (product[event.subtract].amount == 0) {
        if (product[event.subtract].namaProduk == 'Refill Tabung 0,5m\u00B3' ||
            product[event.subtract].namaProduk == 'Refill Tabung 1m\u00B3' ||
            product[event.subtract].namaProduk == 'Refill Tabung 2m\u00B3' ||
            product[event.subtract].namaProduk == 'Refill Tabung 6m\u00B3') {
          final resp = await uploadImageController.deleteImageTabung(
            product[event.subtract].namaProduk!,
            event.namaUser,
          );
          product.removeAt(event.subtract);
          id.removeAt(event.subtract);
        } else {
          product.removeAt(event.subtract);
          id.removeAt(event.subtract);
        }
      }

      double total = 0;
      double pricee = 0;
      int sumAmount = 0;

      product.forEach((element) {
        total = total - (element.price * element.amount);
        pricee = element.price;
        sumAmount = sumAmount + element.amount;
      });
      yield state.copyWith(
          products: product,
          total: total.abs(),
          price: pricee,
          id: id,
          sumAmount: sumAmount);
    } else if (event is DeleteProductFromCart) {
      if (product[event.index].namaProduk == 'Refill Tabung 0,5m\u00B3' ||
          product[event.index].namaProduk == 'Refill Tabung 1m\u00B3' ||
          product[event.index].namaProduk == 'Refill Tabung 2m\u00B3' ||
          product[event.index].namaProduk == 'Refill Tabung 6m\u00B3') {
        await uploadImageController.deleteImageTabung(
          product[event.index].namaProduk!,
          event.namaUser,
        );
        product.removeAt(event.index);
        id.removeAt(event.index);
      } else {
        product.removeAt(event.index);
        id.removeAt(event.index);
      }
      if (product.length == 0) {
        id.clear();
        product.clear();
      }
      double sum = 0;
      double pricee = 0;
      int sumAmount = 0;
      product.forEach((element) {
        sumAmount = sumAmount + element.amount;
        sum = sum + (element.price * element.amount);
      });
      yield state.copyWith(
        products: product,
        total: sum,
        amount: product.length,
        price: pricee,
        sumAmount: sumAmount,
        id: id,
      );
    } else if (event is ClearProductEvent) {
      product.clear();
      yield state.copyWith(
        products: product,
        total: 0,
        amount: 0,
        price: 0,
        id: [],
      );
    }
  }
}
