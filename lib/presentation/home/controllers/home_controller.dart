import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../domain/models/product_model.dart';
import '../../../domain/repositories/product_repository.dart';
import '../../../data/providers/api_provider.dart';

class HomeController extends GetxController {
  final ProductRepository repository =
      ProductRepository(apiProvider: ApiProvider());

  final products = <Product>[].obs;
  final categories = <String>[].obs;

  final isLoadingProducts = true.obs;
  final isLoadingCategories = true.obs;

  final selectedCategory = 'All'.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
    fetchProducts();
  }

  Future<void> fetchCategories() async {
    try {
      isLoadingCategories(true);
      final fetchedCategories = await repository.fetchCategories();
      categories.assignAll(['All', ...fetchedCategories]);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load categories');
    } finally {
      isLoadingCategories(false);
    }
  }

  Future<void> fetchProducts({String? category}) async {
    try {
      isLoadingProducts(true);
      final fetchedProducts = await repository.fetchAllProducts();

      print('fetchedProducts: ${fetchedProducts.length}');
      if (category == null || category == 'All') {
        products.assignAll(fetchedProducts);
      } else {
        products.assignAll(
            fetchedProducts.where((p) => p.category == category).toList());
      }
    } catch (e, stack) {
      Get.snackbar('Error', 'Failed to load products');
      debugPrint('fetchProducts error: $e');
      debugPrint(stack.toString());
    } finally {
      isLoadingProducts(false);
    }
  }

  void onCategorySelected(String category) {
    selectedCategory.value = category;
    fetchProducts(category: category);
  }
}
