# Flutter E-Commerce Boilerplate (GetX)

A production-ready, clean, and scalable Flutter Boilerplate tailored specifically for e-commerce applications. This starter setup relies on [GetX](https://pub.dev/packages/get) for simplified state management, dependency injection, and routing.

## Features Included 🚀
- **Clean Architecture & Feature-based Modules:** Well-organized folder structure isolating core, data, domain, and presentation components.
- **GetX Routing & State Management:** Dynamic and reactive UI using `Obx` and `GetView`.
- **Global App State:** Reactive `CartService` and `WishlistService` running globally across the app.
- **API Setup:** Structured dummy API repository utilizing the [Fake Store API](https://fakestoreapi.com/) via HTTP.
- **Core Screens:**
  1. Product Listing (Home) with category filtering.
  2. Product Details
  3. Shopping Cart integration & quantity management
  4. Wishlist / Favorites toggling
  5. Dummy Checkout Flow
  6. Order History
- **Themes & UI Assets:** Responsive generic `CustomButton`, `EmptyState`, and stylized `ProductCard`. Theme configuration is available centrally in `app_theme.dart`.

## Folder Structure 📁

```text
lib/
├── core/                   # Shared configurations and constants
│   ├── constants/
│   ├── routes/             # AppPages mapped routes
│   └── theme/
├── data/                   # API Providers & DTO mapping
│   └── providers/
├── domain/                 # Business logic models and repositories
│   ├── models/
│   └── repositories/
├── presentation/           # GetX feature modules
│   ├── cart/               # -> views, bindings, controllers
│   ├── checkout/
│   ├── home/
│   ├── orders/
│   ├── product_details/
│   ├── splash/
│   └── wishlist/
├── services/               # Globally injected GetxServices (Cart, Wishlist)
├── widgets/                # Reusable cross-app UI widgets
└── main.dart               # App initialization
```

## Setup Instructions 🛠️
1. **Clone or create** the project directory.
2. In your terminal, run `flutter pub get` inside the project root to install `get`, `http`, `cached_network_image`, etc.
3. Run the application:
   ```bash
   flutter run
   ```

## Dummy Data Integration ⚡
The `ApiProvider` under `data/providers/api_provider.dart` connects directly to `https://fakestoreapi.com/products`. If you wish to replace this with your own production service:
1. Modify the `ApiProvider` base URL.
2. Ensure your backend objects conform to the structure listed in `domain/models/product_model.dart`, or adjust `Product.fromJson` logic accordingly.

## Adding New Modules
If you want to add a new "Profile" module:
1. Run `mkdir lib/presentation/profile/{views,controllers,bindings}`
2. Create `ProfileController` extending `GetxController`.
3. Create `ProfileBinding` mapping the injection: `Get.lazyPut(() => ProfileController())`.
4. Create `ProfileView` extending `GetView<ProfileController>`.
5. Wire up the paths in `core/routes/app_pages.dart`.
