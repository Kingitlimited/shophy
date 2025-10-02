// lib/ui/widgets/home/featured_products.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shophy/ui/widget/home/product_card.dart';
import '../../../utils/size_config.dart';
import '../../../models/product_model.dart';

class FeaturedProducts extends ConsumerWidget {
  final List<Product> featuredProducts;
  final VoidCallback? onViewAllPressed;
  final Function(Product)? onProductTap;

  const FeaturedProducts({
    Key? key,
    required this.featuredProducts,
    this.onViewAllPressed,
    this.onProductTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (featuredProducts.isEmpty) {
      return SizedBox.shrink(); // Don't show if no featured products
    }

    return Container(
      margin: EdgeInsets.only(bottom: SizeConfig.getProportionateScreenHeight(20)),
      child: Column(
        children: [
          // Header Section
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.getProportionateScreenWidth(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Featured Products',
                  style: TextStyle(
                    fontSize: SizeConfig.getProportionateScreenWidth(20),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: onViewAllPressed,
                  child: Row(
                    children: [
                      Text(
                        'View All',
                        style: TextStyle(
                          fontSize: SizeConfig.getProportionateScreenWidth(14),
                          color: Colors.blue,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: SizeConfig.getProportionateScreenWidth(4)),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.blue,
                        size: SizeConfig.getProportionateScreenWidth(12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: SizeConfig.getProportionateScreenHeight(16)),

          // Products Grid
          Container(
            height: SizeConfig.getProportionateScreenHeight(280),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(
                left: SizeConfig.getProportionateScreenWidth(16),
                right: SizeConfig.getProportionateScreenWidth(16),
              ),
              itemCount: featuredProducts.length,
              itemBuilder: (context, index) {
                final product = featuredProducts[index];
                return Container(
                  width: SizeConfig.getProportionateScreenWidth(160),
                  margin: EdgeInsets.only(
                    right: SizeConfig.getProportionateScreenWidth(12),
                  ),
                  child: ProductCard(
                    product: product,
                    onTap: () {
                      onProductTap?.call(product);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}