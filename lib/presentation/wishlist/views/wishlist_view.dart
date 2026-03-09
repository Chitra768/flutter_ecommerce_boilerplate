import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../services/wishlist_service.dart';
import '../../../widgets/product_card.dart';
import '../../../widgets/empty_state.dart';

class WishlistView extends StatelessWidget {
  const WishlistView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final wishlist = Get.find<WishlistService>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Wishlist'),
      ),
      body: Obx(() {
        if (wishlist.items.isEmpty) {
          return const EmptyState(
            title: 'No Favorites Yet',
            message: 'Browse products and tap the heart icon to add them to your wishlist.',
            icon: Icons.favorite_border,
          );
        }

        return GridView.builder(
          padding: const EdgeInsets.all(12),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.65,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: wishlist.items.length,
          itemBuilder: (context, index) {
            final product = wishlist.items.values.elementAt(index);
            return ProductCard(product: product);
          },
        );
      }),
    );
  }
}
