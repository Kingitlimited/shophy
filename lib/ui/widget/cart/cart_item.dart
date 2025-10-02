// lib/ui/widgets/cart/cart_item.dart
import 'package:flutter/material.dart';
import 'package:shophy/models/cart_model.dart';
import '../../../utils/size_config.dart';


class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;
  final VoidCallback onRemove;
  final VoidCallback? onTap;

  const CartItemWidget({
    Key? key,
    required this.cartItem,
    required this.onIncrease,
    required this.onDecrease,
    required this.onRemove,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: SizeConfig.getProportionateScreenHeight(12)),
        padding: EdgeInsets.all(SizeConfig.getProportionateScreenWidth(16)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            _buildProductImage(),
            SizedBox(width: SizeConfig.getProportionateScreenWidth(12)),
            
            // Product Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProductInfo(),
                  SizedBox(height: SizeConfig.getProportionateScreenHeight(12)),
                  _buildQuantityControls(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductImage() {
    return Container(
      width: SizeConfig.getProportionateScreenWidth(80),
      height: SizeConfig.getProportionateScreenWidth(80),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey[100],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(
          cartItem.image,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.shopping_bag,
                color: Colors.grey[400],
                size: SizeConfig.getProportionateScreenWidth(30),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildProductInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                cartItem.productTitle,
                style: TextStyle(
                  fontSize: SizeConfig.getProportionateScreenWidth(16),
                  fontWeight: FontWeight.w600,
                  height: 1.3,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(width: SizeConfig.getProportionateScreenWidth(8)),
            GestureDetector(
              onTap: onRemove,
              child: Container(
                width: SizeConfig.getProportionateScreenWidth(32),
                height: SizeConfig.getProportionateScreenWidth(32),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red.withOpacity(0.1),
                ),
                child: Icon(
                  Icons.close,
                  color: Colors.red,
                  size: SizeConfig.getProportionateScreenWidth(18),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: SizeConfig.getProportionateScreenHeight(8)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '\$${cartItem.price.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: SizeConfig.getProportionateScreenWidth(18),
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.getProportionateScreenWidth(8),
                vertical: SizeConfig.getProportionateScreenHeight(4),
              ),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                'In Stock',
                style: TextStyle(
                  fontSize: SizeConfig.getProportionateScreenWidth(12),
                  fontWeight: FontWeight.w600,
                  color: Colors.green,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQuantityControls() {
    return Row(
      children: [
        // Decrease Button
        Container(
          width: SizeConfig.getProportionateScreenWidth(36),
          height: SizeConfig.getProportionateScreenWidth(36),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: cartItem.quantity > 1 ? Colors.grey[100] : Colors.grey[50],
            border: Border.all(
              color: cartItem.quantity > 1 ? Colors.grey[300]! : Colors.grey[200]!,
            ),
          ),
          child: IconButton(
            icon: Icon(
              Icons.remove,
              color: cartItem.quantity > 1 ? Colors.grey[700] : Colors.grey[400],
              size: SizeConfig.getProportionateScreenWidth(16),
            ),
            onPressed: cartItem.quantity > 1 ? onDecrease : null,
            padding: EdgeInsets.zero,
            splashRadius: SizeConfig.getProportionateScreenWidth(20),
          ),
        ),
        
        // Quantity Display
        Container(
          width: SizeConfig.getProportionateScreenWidth(50),
          child: Text(
            cartItem.quantity.toString(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: SizeConfig.getProportionateScreenWidth(16),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        
        // Increase Button
        Container(
          width: SizeConfig.getProportionateScreenWidth(36),
          height: SizeConfig.getProportionateScreenWidth(36),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.blue[50],
            border: Border.all(color: Colors.blue[100]!),
          ),
          child: IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.blue,
              size: SizeConfig.getProportionateScreenWidth(16),
            ),
            onPressed: onIncrease,
            padding: EdgeInsets.zero,
            splashRadius: SizeConfig.getProportionateScreenWidth(20),
          ),
        ),
        
        Spacer(),
        
        // Total Price
        Text(
          '\$${cartItem.totalPrice.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: SizeConfig.getProportionateScreenWidth(16),
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}