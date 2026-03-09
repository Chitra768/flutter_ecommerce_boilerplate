import 'package:get/get.dart';
import '../../domain/models/product_model.dart';

class WishlistService extends GetxService {
  final items = <String, Product>{}.obs;

  bool isFavorite(String productId) => items.containsKey(productId);

  void toggleFavorite(Product product) {
    if (isFavorite(product.id)) {
      items.remove(product.id);
    } else {
      items.putIfAbsent(product.id, () => product);
    }
  }
}
