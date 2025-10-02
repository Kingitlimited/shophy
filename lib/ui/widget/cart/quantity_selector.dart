// lib/ui/widgets/cart/quantity_selector.dart
import 'package:flutter/material.dart';
import '../../../utils/size_config.dart';

class QuantitySelector extends StatelessWidget {
  final int quantity;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;
  final Color? activeColor;
  final Color? inactiveColor;

  const QuantitySelector({
    Key? key,
    required this.quantity,
    required this.onIncrease,
    required this.onDecrease,
    this.activeColor,
    this.inactiveColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeActiveColor = activeColor ?? Colors.blue;
    final themeInactiveColor = inactiveColor ?? Colors.grey[300]!;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Decrease Button
          Container(
            width: SizeConfig.getProportionateScreenWidth(36),
            height: SizeConfig.getProportionateScreenWidth(36),
            decoration: BoxDecoration(
              color: quantity > 1 ? Colors.white : Colors.grey[50],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
            ),
            child: IconButton(
              icon: Icon(
                Icons.remove,
                color: quantity > 1 ? themeActiveColor : themeInactiveColor,
                size: SizeConfig.getProportionateScreenWidth(16),
              ),
              onPressed: quantity > 1 ? onDecrease : null,
              padding: EdgeInsets.zero,
              splashRadius: SizeConfig.getProportionateScreenWidth(20),
            ),
          ),

          // Quantity Display
          Container(
            width: SizeConfig.getProportionateScreenWidth(40),
            height: SizeConfig.getProportionateScreenWidth(36),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.symmetric(
                vertical: BorderSide(color: Colors.grey[300]!),
              ),
            ),
            child: Center(
              child: Text(
                quantity.toString(),
                style: TextStyle(
                  fontSize: SizeConfig.getProportionateScreenWidth(14),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          // Increase Button
          Container(
            width: SizeConfig.getProportionateScreenWidth(36),
            height: SizeConfig.getProportionateScreenWidth(36),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
            ),
            child: IconButton(
              icon: Icon(
                Icons.add,
                color: themeActiveColor,
                size: SizeConfig.getProportionateScreenWidth(16),
              ),
              onPressed: onIncrease,
              padding: EdgeInsets.zero,
              splashRadius: SizeConfig.getProportionateScreenWidth(20),
            ),
          ),
        ],
      ),
    );
  }
}