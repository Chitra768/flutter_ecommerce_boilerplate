# Flutter E-Commerce Boilerplate (GetX)

**A production-ready Flutter e-commerce starter built with Flutter and GetX.**

This boilerplate gives you a clean architecture, modular folder structure, reusable widgets, and scalable state management. It works for both beginners learning Flutter and experienced developers shipping production apps. The goal is to cut development time by providing a solid base for e-commerce applications.

---

## Key Features

### Clean Architecture

The project uses a layered architecture:

| Layer | Purpose |
|-------|---------|
| **Core** | Shared config, routes, theme |
| **Data** | API providers and data sources |
| **Domain** | Models and repositories |
| **Presentation** | UI, controllers, bindings |

This keeps the codebase maintainable, scalable, and testable.

### GetX State Management

GetX is used for:

- **State management** — reactive updates with `Obx`, `GetBuilder`, `GetView`
- **Dependency injection** — `Get.put`, `Get.lazyPut`, bindings
- **Route management** — named routes and transitions

### Global App Services

App-wide state is handled by services that extend **GetxService**:

- **CartService** — cart items across the app
- **WishlistService** — favorite products

They stay available for the whole app lifecycle.

---

## Application Modules

| Module | Description |
|--------|-------------|
| **Home / Product listing** | Product grid, category filters, pull-to-refresh |
| **Product details** | Image, description, price, add to cart, wishlist toggle |
| **Cart** | View items, change quantity, remove items |
| **Wishlist** | Add/remove favorites, view saved products |
| **Checkout** | Simple checkout and order confirmation |
| **Order history** | List of past orders |

---

## API Integration

- **Default API:** [Fake Store API](https://fakestoreapi.com/products) (products + categories).
- **Fallback:** If the network fails (e.g. emulator DNS), the app uses bundled mock product data so it still runs offline.

**API code:** `lib/data/providers/api_provider.dart`

**To use your own backend:**

1. Change the base URL in **ApiProvider**.
2. Adjust **Product.fromJson** in `lib/domain/models/product_model.dart` if your API shape differs.
3. Update repository methods if needed.

---

## Folder Structure

```
lib/
├── core/
│   ├── routes/          # GetX routes (app_pages.dart, app_routes.dart)
│   └── theme/           # App theme and colors
├── data/
│   ├── mock/            # Fallback mock product data
│   └── providers/       # API provider
├── domain/
│   ├── models/          # Product, CartItem, etc.
│   └── repositories/    # ProductRepository
├── presentation/
│   ├── cart/
│   ├── checkout/
│   ├── home/
│   ├── orders/
│   ├── product_details/
│   ├── splash/
│   └── wishlist/
├── services/            # CartService, WishlistService
├── widgets/             # Reusable UI components
└── main.dart
```

Each feature under **presentation** uses: `bindings/`, `controllers/`, `views/`.

---

## Reusable UI Components

| Widget | Use |
|--------|-----|
| **ProductCard** | Product grid item (image, title, price, actions) |
| **CustomButton** | Primary/secondary buttons |
| **EmptyState** | Empty cart, empty wishlist, no products |

These keep the UI consistent across screens.

---

## Theme Configuration

Theming is in **`lib/core/theme/`**:

- **app_theme.dart** — light/dark theme, typography, button styles
- **app_colors.dart** — primary, background, text colors

Edit these to match your brand.

---

## Getting Started

### 1. Clone the repository

```bash
git clone https://github.com/Chitra768/flutter_ecommerce_boilerplate.git
```

### 2. Open the project

```bash
cd flutter_ecommerce_boilerplate
```

### 3. Install dependencies

```bash
flutter pub get
```

### 4. Run the app

```bash
flutter run
```

To run on a specific device (e.g. Android emulator):

```bash
flutter devices
flutter run -d <device_id>
```

---

## Dependencies

Main packages (see **pubspec.yaml** for full list):

- **get** — state management, routing, DI
- **http** — API calls
- **cached_network_image** — image caching
- **shared_preferences** — local persistence
- **flutter_svg** — SVG support

---

## Adding a New Module

Example: adding a **Profile** feature.

**Step 1 — Folder structure**

```
lib/presentation/profile/
├── bindings/
├── controllers/
└── views/
```

**Step 2 — Controller** (`profile_controller.dart`)

```dart
class ProfileController extends GetxController {
  // your logic
}
```

**Step 3 — Binding** (`profile_binding.dart`)

```dart
class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileController());
  }
}
```

**Step 4 — View** (`profile_view.dart`)

```dart
class ProfileView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(/* ... */);
  }
}
```

**Step 5 — Route**

In **`lib/core/routes/app_pages.dart`**, add a `GetPage` for the profile route and register it in **`app_routes.dart`**.

---

## Best Practices in This Boilerplate

- **Feature-based structure** — one folder per feature (cart, wishlist, etc.)
- **Separation of concerns** — data / domain / presentation
- **Reusable widgets** — shared components in `lib/widgets/`
- **Global services** — cart and wishlist as GetxServices
- **Structured API layer** — provider + repository pattern

---

## Who Is This For?

- **Beginners** — learn clean architecture and GetX with a real app structure.
- **Experienced devs** — use as a production-ready e-commerce starter and extend modules as needed.

---


## License

This project can be used as a starter template for Flutter e-commerce applications.
