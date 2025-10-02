// lib/ui/widgets/home/product_card.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../utils/size_config.dart';
import '../../../models/product_model.dart';
import '../../../providers/cart_provider.dart';

class ProductCard extends ConsumerWidget {
  final Product product;
  final VoidCallback? onTap;
  final bool showFavorite;

  const ProductCard({
    Key? key,
    required this.product,
    this.onTap,
    this.showFavorite = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final defaultVariant = product.defaultVariant;
    final firstImage = product.images.isNotEmpty ? product.images.first.src : 'assets/images/product_placeholder.jpg';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(SizeConfig.getProportionateScreenWidth(12)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image with Favorite Button
            Stack(
              children: [
                // Product Image
                Container(
                  height: SizeConfig.getProportionateScreenHeight(140),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(SizeConfig.getProportionateScreenWidth(12)),
                    ),
                    color: Colors.grey[200],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(SizeConfig.getProportionateScreenWidth(12)),
                    ),
                    child: Image.asset(
                      firstImage,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[200],
                          child: Icon(
                            Icons.shopping_bag,
                            color: Colors.grey[400],
                            size: SizeConfig.getProportionateScreenWidth(40),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                // Favorite Button
                if (showFavorite)
                  Positioned(
                    top: SizeConfig.getProportionateScreenWidth(8),
                    right: SizeConfig.getProportionateScreenWidth(8),
                    child: Container(
                      width: SizeConfig.getProportionateScreenWidth(32),
                      height: SizeConfig.getProportionateScreenWidth(32),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.favorite_border,
                          color: Colors.grey[600],
                          size: SizeConfig.getProportionateScreenWidth(16),
                        ),
                        onPressed: () {
                          print('Add to favorites: ${product.title}');
                        },
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  ),

                // Rating Badge
                if (product.reviewCount > 0)
                  Positioned(
                    top: SizeConfig.getProportionateScreenWidth(8),
                    left: SizeConfig.getProportionateScreenWidth(8),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.getProportionateScreenWidth(6),
                        vertical: SizeConfig.getProportionateScreenHeight(2),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.orange.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.white,
                            size: SizeConfig.getProportionateScreenWidth(12),
                          ),
                          SizedBox(width: SizeConfig.getProportionateScreenWidth(2)),
                          Text(
                            product.averageRating.toStringAsFixed(1),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: SizeConfig.getProportionateScreenWidth(10),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                // Sale Badge
                if (defaultVariant.onSale)
                  Positioned(
                    bottom: SizeConfig.getProportionateScreenWidth(8),
                    left: SizeConfig.getProportionateScreenWidth(8),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.getProportionateScreenWidth(6),
                        vertical: SizeConfig.getProportionateScreenHeight(2),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'SALE',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: SizeConfig.getProportionateScreenWidth(10),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),

            // Product Info
            Padding(
              padding: EdgeInsets.all(SizeConfig.getProportionateScreenWidth(12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Name
                  Text(
                    product.title,
                    style: TextStyle(
                      fontSize: SizeConfig.getProportionateScreenWidth(14),
                      fontWeight: FontWeight.w500,
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: SizeConfig.getProportionateScreenHeight(6)),

                  // Price
                  Row(
                    children: [
                      Text(
                        '\$${defaultVariant.price.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: SizeConfig.getProportionateScreenWidth(16),
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      if (defaultVariant.onSale) ...[
                        SizedBox(width: SizeConfig.getProportionateScreenWidth(4)),
                        Text(
                          '\$${defaultVariant.compareAtPrice!.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: SizeConfig.getProportionateScreenWidth(12),
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ],
                  ),
                  SizedBox(height: SizeConfig.getProportionateScreenHeight(6)),

                  // Add to Cart Button
                  Container(
                    width: double.infinity,
                    height: SizeConfig.getProportionateScreenHeight(32),
                    child: ElevatedButton(
                      onPressed: () {
                        ref.read(cartProvider.notifier).addToCart(product);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Added ${product.title} to cart'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.zero,
                      ),
                      child: Text(
                        'Add to Cart',
                        style: TextStyle(
                          fontSize: SizeConfig.getProportionateScreenWidth(12),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}