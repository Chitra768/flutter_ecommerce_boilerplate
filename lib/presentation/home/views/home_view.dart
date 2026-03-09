import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/routes/app_pages.dart';
import '../../../../widgets/product_card.dart';
import '../../../../widgets/empty_state.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Shop'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () => Get.toNamed(Routes.WISHLIST),
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () => Get.toNamed(Routes.CART),
          ),
        ],
      ),
      body: Column(
        children: [
          // Categories
          SizedBox(
            height: 60,
            child: Obx(() {
              if (controller.isLoadingCategories.value) {
                return const Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.categories.length,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                itemBuilder: (context, index) {
                  final category = controller.categories[index];
                  final isSelected =
                      category == controller.selectedCategory.value;

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: ChoiceChip(
                      label: Text(category.capitalizeFirst ?? category),
                      selected: isSelected,
                      onSelected: (selected) {
                        if (selected) controller.onCategorySelected(category);
                      },
                      selectedColor: AppColors.primary,
                      labelStyle: TextStyle(
                        color: isSelected
                            ? Colors.white
                            : AppColors.textPrimary,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  );
                },
              );
            }),
          ),

          // Products
          Expanded(
            child: Obx(() {
              if (controller.isLoadingProducts.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.products.isEmpty) {
                return const EmptyState(
                  title: 'No Products Found',
                  message: 'We could not find any products in this category.',
                  icon: Icons.inventory_2_outlined,
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
                itemCount: controller.products.length,
                itemBuilder: (context, index) {
                  return ProductCard(product: controller.products[index]);
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
