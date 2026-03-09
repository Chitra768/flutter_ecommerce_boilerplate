import 'package:get/get.dart';
import '../../presentation/splash/views/splash_view.dart';
import '../../presentation/splash/bindings/splash_binding.dart';
import '../../presentation/home/views/home_view.dart';
import '../../presentation/home/bindings/home_binding.dart';
import '../../presentation/product_details/views/product_details_view.dart';
import '../../presentation/product_details/bindings/product_details_binding.dart';
import '../../presentation/cart/views/cart_view.dart';
import '../../presentation/cart/bindings/cart_binding.dart';
import '../../presentation/checkout/views/checkout_view.dart';
import '../../presentation/checkout/bindings/checkout_binding.dart';
import '../../presentation/wishlist/views/wishlist_view.dart';
import '../../presentation/wishlist/bindings/wishlist_binding.dart';
import '../../presentation/orders/views/orders_view.dart';
import '../../presentation/orders/bindings/orders_binding.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.PRODUCT_DETAILS,
      page: () => const ProductDetailsView(),
      binding: ProductDetailsBinding(),
    ),
    GetPage(
      name: Routes.CART,
      page: () => const CartView(),
      binding: CartBinding(),
    ),
    GetPage(
      name: Routes.CHECKOUT,
      page: () => const CheckoutView(),
      binding: CheckoutBinding(),
    ),
    GetPage(
      name: Routes.WISHLIST,
      page: () => const WishlistView(),
      binding: WishlistBinding(),
    ),
    GetPage(
      name: Routes.ORDERS,
      page: () => const OrdersView(),
      binding: OrdersBinding(),
    ),
  ];
}
