# Custom Product Grid Widgets

This package contains custom, responsive product grid widgets with pagination and Lottie loading animations for the Elevate Flower App.

## Components

### 1. CustomProductItem
A beautiful product card widget that displays:
- Product image with cached network loading
- Product name
- Price with discount support
- Discount badge (percentage)
- Add to cart button

**Features:**
- Responsive design
- Cached image loading with placeholder
- Discount calculation and display
- Customizable callbacks

### 2. CustomProductGridView
A responsive grid view with **infinite scroll pagination**.

**Features:**
- Automatic pagination on scroll
- Responsive column count (2-4 columns based on screen size)
- Lottie loading animation
- Empty state handling
- Scroll-based load more (triggers at 80% scroll)

**Responsive Breakpoints:**
- Mobile (< 600px): 2 columns
- Tablet Portrait (600-900px): 2 columns
- Tablet Landscape (900-1200px): 3 columns
- Desktop (>= 1200px): 4 columns

### 3. PaginatedProductGridView
A responsive grid view with **page number pagination**.

**Features:**
- Page number controls with previous/next buttons
- Smart page number display (shows max 5 pages at a time)
- Ellipsis for large page ranges
- Lottie loading animation
- Empty state handling
- Responsive design

## Usage

### Infinite Scroll Example

```dart
import 'package:elevate_flower_app/core/shared/widgets/custom_product_grid_view.dart';

class MyProductPage extends StatefulWidget {
  @override
  State<MyProductPage> createState() => _MyProductPageState();
}

class _MyProductPageState extends State<MyProductPage> {
  List<ProductItemEntity> products = [];
  bool isLoading = false;
  bool hasMore = true;

  Future<void> loadMore() async {
    if (isLoading || !hasMore) return;
    
    setState(() => isLoading = true);
    
    // Your API call here
    final newProducts = await fetchProducts();
    
    setState(() {
      products.addAll(newProducts);
      isLoading = false;
      hasMore = newProducts.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomProductGridView(
        products: products,
        isLoading: isLoading,
        hasMore: hasMore,
        onLoadMore: loadMore,
        onProductTap: (product) {
          // Navigate to product details
        },
        onAddToCart: (product) {
          // Add to cart logic
        },
      ),
    );
  }
}
```

### Paginated Example

```dart
import 'package:elevate_flower_app/core/shared/widgets/paginated_product_grid_view.dart';

class MyProductPage extends StatefulWidget {
  @override
  State<MyProductPage> createState() => _MyProductPageState();
}

class _MyProductPageState extends State<MyProductPage> {
  List<ProductItemEntity> products = [];
  bool isLoading = false;
  int currentPage = 1;
  int totalPages = 10;

  Future<void> loadPage(int page) async {
    setState(() {
      isLoading = true;
      currentPage = page;
    });
    
    // Your API call here
    final pageProducts = await fetchProductsForPage(page);
    
    setState(() {
      products = pageProducts;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PaginatedProductGridView(
        products: products,
        isLoading: isLoading,
        currentPage: currentPage,
        totalPages: totalPages,
        onPageChanged: loadPage,
        onProductTap: (product) {
          // Navigate to product details
        },
        onAddToCart: (product) {
          // Add to cart logic
        },
      ),
    );
  }
}
```

### Using CustomProductItem Standalone

```dart
import 'package:elevate_flower_app/core/shared/widgets/custom_product_item.dart';

CustomProductItem(
  product: ProductItemEntity(
    id: '1',
    name: 'Red Roses',
    price: 800.0,
    priceAfterDiscount: 600.0,
    imageUrl: 'https://example.com/image.jpg',
  ),
  onTap: () {
    // Handle product tap
  },
  onAddToCart: () {
    // Handle add to cart
  },
)
```

## API Integration Example

### With Bloc/Cubit

```dart
class ProductsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        return CustomProductGridView(
          products: state.products,
          isLoading: state.isLoading,
          hasMore: state.hasMore,
          onLoadMore: () {
            context.read<ProductsCubit>().loadMore();
          },
          onProductTap: (product) {
            context.push('/product/${product.id}');
          },
          onAddToCart: (product) {
            context.read<CartCubit>().addToCart(product);
          },
        );
      },
    );
  }
}
```

## Customization

### Adjusting Items Per Page
```dart
// For infinite scroll
const int itemsPerPage = 20; // Fetch 20 items per request

// For paginated view
PaginatedProductGridView(
  // ... other params
  // The widget will display all products in the list
  // Your backend should return the correct number per page
)
```

### Custom Scroll Controller
```dart
final scrollController = ScrollController();

CustomProductGridView(
  scrollController: scrollController,
  // ... other params
)
```

### Changing Responsive Breakpoints
Edit the `_getCrossAxisCount` method in the widget files to adjust breakpoints:

```dart
int _getCrossAxisCount(BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  
  if (width >= 1400) return 5;  // Extra large screens
  if (width >= 1200) return 4;  // Desktop
  if (width >= 900) return 3;   // Tablet landscape
  if (width >= 600) return 2;   // Tablet portrait
  return 2;                      // Mobile
}
```

## Dependencies

These widgets use the following packages:
- `flutter_screenutil` - Responsive sizing
- `cached_network_image` - Image caching
- `lottie` - Loading animations
- `gap` - Spacing
- `flutter_bloc` - State management (optional, for integration)

## Loading Animation

The widgets use the Lottie animation located at:
```
assets/animations/Loading_animation.json
```

Make sure this file exists in your project. You can replace it with any Lottie animation by updating `AppAnimations.animationsLoadingAnimation`.

## Testing

Run the example page to see both pagination styles in action:
```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => ProductGridExamplePage(),
  ),
);
```

## Notes

- The infinite scroll triggers loading when the user scrolls to 80% of the content
- Page numbers show a maximum of 5 pages at a time with ellipsis for large ranges
- Empty states are automatically handled
- All widgets are fully responsive and adapt to different screen sizes
- Images are cached for better performance
- Loading states use Lottie animations for a premium feel

## Support

For issues or questions, please refer to the project documentation or contact the development team.
