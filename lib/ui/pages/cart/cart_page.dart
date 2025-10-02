// lib/ui/pages/cart/cart_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shophy/providers/cart_provider.dart';
import 'package:shophy/ui/widget/cart/cart_item.dart';
import 'package:shophy/ui/widget/cart/cart_summary.dart';
import 'package:shophy/ui/widget/common/empty_state.dart';
import 'package:shophy/utils/size_config.dart';



class CartPage extends ConsumerWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);
    
    SizeConfig.init(context);
    
    return Scaffold(
      body: Column(
        children: [
          // Header
          Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 16,
              left: SizeConfig.getProportionateScreenWidth(16),
              right: SizeConfig.getProportionateScreenWidth(16),
              bottom: SizeConfig.getProportionateScreenHeight(16),
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 3,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios, size: SizeConfig.getProportionateScreenWidth(20)),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(width: SizeConfig.getProportionateScreenWidth(8)),
                Text(
                  'Shopping Cart',
                  style: TextStyle(
                    fontSize: SizeConfig.getProportionateScreenWidth(20),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                Text(
                  '${cart.totalItems} ${cart.totalItems == 1 ? 'item' : 'items'}',
                  style: TextStyle(
                    fontSize: SizeConfig.getProportionateScreenWidth(14),
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),

          // Cart Content
          Expanded(
            child: cart.isEmpty
                ? EmptyState(
                    title: 'Your cart is empty',
                    description: 'Add some products to your cart',
                    icon: Icons.shopping_cart_outlined,
                    buttonText: 'Browse Products',
                    onButtonPressed: () {
                      // Navigate to products page
                      Navigator.pop(context);
                    },
                  )
                : SingleChildScrollView(
                    padding: EdgeInsets.all(SizeConfig.getProportionateScreenWidth(16)),
                    child: Column(
                      children: [
                        // Cart Items List
                        ...cart.items.map((item) {
                          return CartItemWidget(
                            cartItem: item,
                            onIncrease: () {
                              ref.read(cartProvider.notifier).updateQuantity(
                                item.id,
                                item.quantity + 1,
                              );
                            },
                            onDecrease: () {
                              ref.read(cartProvider.notifier).updateQuantity(
                                item.id,
                                item.quantity - 1,
                              );
                            },
                            onRemove: () {
                              ref.read(cartProvider.notifier).removeFromCart(item.id);
                            },
                            onTap: () {
                              print('Tapped on ${item.productTitle}');
                              // Navigate to product detail
                            },
                          );
                        }).toList(),
                        
                        SizedBox(height: SizeConfig.getProportionateScreenHeight(20)),
                        
                        // Cart Summary
                        CartSummary(
                          subtotal: cart.subtotalPrice,
                          shipping: cart.shipping,
                          tax: cart.tax,
                          onCheckout: () {
                            print('Checkout pressed');
                          },
                          onApplyCoupon: () {
                            print('Apply coupon pressed');
                          },
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}