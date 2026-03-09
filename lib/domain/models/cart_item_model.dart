import 'product_model.dart';
import 'package:get/get.dart';

class CartItem {
  final Product product;
  RxInt quantity;

  CartItem({required this.product, int quantity = 1}) : quantity = quantity.obs;

  double get totalPrice => product.price * quantity.value;
}
