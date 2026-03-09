import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import '../../../domain/models/product_model.dart';
import '../../../core/theme/app_colors.dart';
import '../../../services/cart_service.dart';
import '../../../services/wishlist_service.dart';
import '../../../widgets/custom_button.dart';

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Get.arguments == null || Get.arguments is! Product) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(child: Text('Product not found.')),
      );
    }
    
    final Product product = Get.arguments as Product;
    final cart = Get.find<CartService>();
    final wishlist = Get.find<WishlistService>();

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
        actions: [
          Obx(() => IconButton(
                icon: Icon(
                  wishlist.isFavorite(product.id) ? Icons.favorite : Icons.favorite_border,
                  color: wishlist.isFavorite(product.id) ? AppColors.error : Colors.white,
                ),
                onPressed: () => wishlist.toggleFavorite(product),
              )),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 300,
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: CachedNetworkImage(
                imageUrl: product.imageUrl,
                fit: BoxFit.contain,
                placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          product.title,
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.displayLarge?.copyWith(
                              color: AppColors.primary,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 20),
                      const SizedBox(width: 4),
                      Text(
                        product.rating.toString(),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          product.category.capitalizeFirst ?? product.category,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Description',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: CustomButton(
            text: 'Add to Cart',
            onPressed: () {
              cart.addItem(product);
              Get.snackbar('Success', '${product.title} added to cart', snackPosition: SnackPosition.BOTTOM);
            },
          ),
        ),
      ),
    );
  }
}
