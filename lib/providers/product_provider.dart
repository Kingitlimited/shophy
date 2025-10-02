// lib/providers/product_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product_model.dart';

class ProductState {
  final List<Product> products;
  final List<Product> featuredProducts;
  final bool isLoading;
  final String? error;
  final Map<String, Product> productDetails;

  ProductState({
    this.products = const [],
    this.featuredProducts = const [],
    this.isLoading = false,
    this.error,
    this.productDetails = const {},
  });

  ProductState copyWith({
    List<Product>? products,
    List<Product>? featuredProducts,
    bool? isLoading,
    String? error,
    Map<String, Product>? productDetails,
  }) {
    return ProductState(
      products: products ?? this.products,
      featuredProducts: featuredProducts ?? this.featuredProducts,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      productDetails: productDetails ?? this.productDetails,
    );
  }
}

class ProductNotifier extends StateNotifier<ProductState> {
  ProductNotifier() : super(ProductState());

  Future<void> loadProducts() async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      // Simulate API call
      await Future.delayed(Duration(seconds: 2));
      
      // Mock data
      final products = [
        Product(
          id: '1',
          title: 'Wireless Bluetooth Headphones',
          description: 'High-quality wireless headphones with noise cancellation',
          handle: 'wireless-bluetooth-headphones',
          variants: [
            ProductVariant(
              id: '1-1',
              productId: '1',
              title: 'Default',
              price: 99.99,
              compareAtPrice: 129.99,
            ),
          ],
          images: [
            ProductImage(
              id: '1-1',
              productId: '1',
              position: 1,
              src: 'assets/images/product_placeholder.jpg',
            ),
          ],
          tags: ['electronics', 'audio', 'wireless'],
        ),
        Product(
          id: '2',
          title: 'Smart Watch Series 5',
          description: 'Advanced smartwatch with health monitoring',
          handle: 'smart-watch-series-5',
          variants: [
            ProductVariant(
              id: '2-1',
              productId: '2',
              title: 'Default',
              price: 199.99,
            ),
          ],
          images: [
            ProductImage(
              id: '2-1',
              productId: '2',
              position: 1,
              src: 'assets/images/product_placeholder.jpg',
            ),
          ],
          tags: ['electronics', 'wearable', 'smartwatch'],
        ),
        // Add more mock products...
      ];
      
      state = state.copyWith(
        products: products,
        featuredProducts: products.take(4).toList(),
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: 'Failed to load products: $e');
    }
  }

  Future<void> loadProductDetails(String productId) async {
    try {
      // Simulate API call
      await Future.delayed(Duration(seconds: 1));
      
      // In real app, fetch from API
      // For now, find in existing products
      final product = state.products.firstWhere((p) => p.id == productId);
      
      state = state.copyWith(
        productDetails: {...state.productDetails, productId: product},
      );
    } catch (e) {
      state = state.copyWith(error: 'Failed to load product details: $e');
    }
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}

final productProvider = StateNotifierProvider<ProductNotifier, ProductState>((ref) {
  return ProductNotifier();
});