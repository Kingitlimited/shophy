// lib/providers/cart_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/cart_model.dart';
import '../models/product_model.dart';

class CartNotifier extends StateNotifier<Cart> {
  CartNotifier() : super(Cart.empty());

  void addToCart(Product product, {int quantity = 1, ProductVariant? variant}) {
    final selectedVariant = variant ?? product.defaultVariant;
    
    final existingItemIndex = state.items.indexWhere(
      (item) => item.variantId == selectedVariant.id,
    );

    if (existingItemIndex != -1) {
      // Update quantity if item exists
      final updatedItems = List<CartItem>.from(state.items);
      final existingItem = updatedItems[existingItemIndex];
      updatedItems[existingItemIndex] = existingItem.copyWith(
        quantity: existingItem.quantity + quantity,
      );
      
      state = _updateCartWithItems(updatedItems);
    } else {
      // Add new item
      final newItem = CartItem(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        productId: product.id,
        variantId: selectedVariant.id,
        productTitle: product.title,
        variantTitle: selectedVariant.title,
        price: selectedVariant.price,
        quantity: quantity,
        image: product.images.isNotEmpty ? product.images.first.src : '',
        selectedOptions: selectedVariant.selectedOptions,
      );
      
      state = _updateCartWithItems([...state.items, newItem]);
    }
  }

  void updateQuantity(String cartItemId, int newQuantity) {
    if (newQuantity <= 0) {
      removeFromCart(cartItemId);
      return;
    }

    final updatedItems = state.items.map((item) {
      if (item.id == cartItemId) {
        return item.copyWith(quantity: newQuantity);
      }
      return item;
    }).toList();

    state = _updateCartWithItems(updatedItems);
  }

  void removeFromCart(String cartItemId) {
    final updatedItems = state.items.where((item) => item.id != cartItemId).toList();
    state = _updateCartWithItems(updatedItems);
  }

  void clearCart() {
    state = Cart.empty();
  }

  Cart _updateCartWithItems(List<CartItem> items) {
    final subtotal = items.fold(0.0, (sum, item) => sum + item.totalPrice);
    const shipping = 5.99;
    const taxRate = 0.08;
    final tax = subtotal * taxRate;
    final total = subtotal + shipping + tax;

    return state.copyWith(
      items: items,
      subtotalPrice: subtotal,
      totalPrice: total,
      tax: tax,
      shipping: shipping,
      totalItems: items.fold(0, (sum, item) => sum! + item.quantity),
    );
  }
}

final cartProvider = StateNotifierProvider<CartNotifier, Cart>((ref) {
  return CartNotifier();
});