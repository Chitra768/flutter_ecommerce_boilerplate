import '../../data/providers/api_provider.dart';
import '../models/product_model.dart';

class ProductRepository {
  final ApiProvider apiProvider;

  ProductRepository({required this.apiProvider});

  Future<List<Product>> fetchAllProducts() async {
    return await apiProvider.getProducts();
  }

  Future<Product> fetchProductDetails(String id) async {
    return await apiProvider.getProductDetails(id);
  }

  Future<List<String>> fetchCategories() async {
    return await apiProvider.getCategories();
  }
}
