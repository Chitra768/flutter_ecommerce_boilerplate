import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import '../../domain/models/product_model.dart';
import '../../core/routes/app_pages.dart';
import '../../core/theme/app_colors.dart';
import '../../services/wishlist_service.dart';
import '../../services/cart_service.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final wishlist = Get.find<WishlistService>();
    final cart = Get.find<CartService>();

    return GestureDetector(
      onTap: () => Get.toNamed(Routes.PRODUCT_DETAILS, arguments: product),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(12)),
                    child: CachedNetworkImage(
                      imageUrl: product.imageUrl,
                      fit: BoxFit.contain,
                      width: double.infinity,
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Obx(() => IconButton(
                          icon: Icon(
                            wishlist.isFavorite(product.id)
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: wishlist.isFavorite(product.id)
                                ? AppColors.error
                                : AppColors.textSecondary,
                          ),
                          onPressed: () => wishlist.toggleFavorite(product),
                        )),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: AppColors.primary),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add_shopping_cart,
                            color: AppColors.primary),
                        onPressed: () {
                          cart.addItem(product);
                          Get.snackbar('Added to Cart', product.title,
                              snackPosition: SnackPosition.BOTTOM,
                              duration: const Duration(seconds: 1));
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
