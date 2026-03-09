import 'package:get/get.dart';
import '../../domain/models/cart_item_model.dart';
import '../../domain/models/product_model.dart';

class CartService extends GetxService {
  final items = <String, CartItem>{}.obs;

  int get itemCount => items.length;

  double get totalAmount {
    double total = 0.0;
    items.forEach((key, cartItem) {
      total += cartItem.product.price * cartItem.quantity.value;
    });
    return total;
  }

  void addItem(Product product) {
    if (items.containsKey(product.id)) {
      items[product.id]!.quantity.value += 1;
    } else {
      items.putIfAbsent(product.id, () => CartItem(product: product));
    }
    // TODO: Save to local storage
  }

  void removeItem(String productId) {
    items.remove(productId);
    // TODO: Save to local storage
  }

  void decreaseQuantity(String productId) {
    if (!items.containsKey(productId)) return;

    if (items[productId]!.quantity.value > 1) {
      items[productId]!.quantity.value -= 1;
    } else {
      items.remove(productId);
    }
    // TODO: Save to local storage
  }

  void clear() {
    items.clear();
    // TODO: Save to local storage
  }
}
