// lib/ui/widgets/product/product_list_item.dart
import 'package:flutter/material.dart';
import 'package:shophy/models/product_model.dart';
import 'package:shophy/utils/size_config.dart';

class ProductListItem extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;
  final VoidCallback onAddToCart;

  const ProductListItem({
    Key? key,
    required this.product,
    required this.onTap,
    required this.onAddToCart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final defaultVariant = product.variants.isNotEmpty ? product.defaultVariant : null;
    final firstImage = product.images.isNotEmpty ? product.images.first.src : '';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            _buildProductImage(firstImage),
            
            // Product Info
            Padding(
              padding: EdgeInsets.all(SizeConfig.getProportionateScreenWidth(12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Title
                  Text(
                    product.title,
                    style: TextStyle(
                      fontSize: SizeConfig.getProportionateScreenWidth(14),
                      fontWeight: FontWeight.w600,
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  SizedBox(height: SizeConfig.getProportionateScreenHeight(4)),
                  
                  // Product Type
                  if (product.productType.isNotEmpty) ...[
                    Text(
                      product.productType,
                      style: TextStyle(
                        fontSize: SizeConfig.getProportionateScreenWidth(12),
                        color: Colors.grey[600],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: SizeConfig.getProportionateScreenHeight(4)),
                  ],
                  
                  // Price and Add to Cart
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Price
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (defaultVariant?.compareAtPrice != null &&
                              defaultVariant!.compareAtPrice! > defaultVariant.price)
                            Text(
                              '\$${defaultVariant.compareAtPrice!.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: SizeConfig.getProportionateScreenWidth(12),
                                color: Colors.grey[500],
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          Text(
                            '\$${defaultVariant?.price.toStringAsFixed(2) ?? '0.00'}',
                            style: TextStyle(
                              fontSize: SizeConfig.getProportionateScreenWidth(16),
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                      
                      // Add to Cart Button
                      if (product.available && defaultVariant?.available == true)
                        GestureDetector(
                          onTap: onAddToCart,
                          child: Container(
                            width: SizeConfig.getProportionateScreenWidth(32),
                            height: SizeConfig.getProportionateScreenWidth(32),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.blue[50],
                              border: Border.all(color: Colors.blue[100]!),
                            ),
                            child: Icon(
                              Icons.add_shopping_cart,
                              color: Colors.blue,
                              size: SizeConfig.getProportionateScreenWidth(16),
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductImage(String imageUrl) {
    return Stack(
      children: [
        // Product Image
        Container(
          width: double.infinity,
          height: SizeConfig.getProportionateScreenWidth(120),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            color: Colors.grey[100],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: imageUrl.isNotEmpty 
                ? Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return _buildImagePlaceholder();
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                  )
                : _buildImagePlaceholder(),
          ),
        ),
        
        // Sale Badge
        if (product.variants.isNotEmpty && product.defaultVariant.onSale)
          Positioned(
            top: SizeConfig.getProportionateScreenWidth(8),
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
                  fontSize: SizeConfig.getProportionateScreenWidth(10),
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        
        // Out of Stock Overlay
        if (!product.available || (product.variants.isNotEmpty && !product.defaultVariant.available))
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              ),
              child: Center(
                child: Text(
                  'OUT OF STOCK',
                  style: TextStyle(
                    fontSize: SizeConfig.getProportionateScreenWidth(12),
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildImagePlaceholder() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
      ),
      child: Icon(
        Icons.shopping_bag,
        color: Colors.grey[400],
        size: SizeConfig.getProportionateScreenWidth(32),
      ),
    );
  }
}