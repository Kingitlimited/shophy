// lib/ui/widgets/cart/cart_summary.dart
import 'package:flutter/material.dart';
import '../../../utils/size_config.dart';

class CartSummary extends StatelessWidget {
  final double subtotal;
  final double shipping;
  final double tax;
  final VoidCallback onCheckout;
  final VoidCallback? onApplyCoupon;

  const CartSummary({
    Key? key,
    required this.subtotal,
    required this.shipping,
    required this.tax,
    required this.onCheckout,
    this.onApplyCoupon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final total = subtotal + shipping + tax;

    return Container(
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
      child: Column(
        children: [
          // Order Summary Title
          Row(
            children: [
              Icon(
                Icons.receipt_long,
                color: Colors.blue,
                size: SizeConfig.getProportionateScreenWidth(20),
              ),
              SizedBox(width: SizeConfig.getProportionateScreenWidth(8)),
              Text(
                'Order Summary',
                style: TextStyle(
                  fontSize: SizeConfig.getProportionateScreenWidth(18),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: SizeConfig.getProportionateScreenHeight(16)),

          // Coupon Code Section
          _buildCouponSection(),
          SizedBox(height: SizeConfig.getProportionateScreenHeight(16)),

          // Price Breakdown
          _buildPriceBreakdown(subtotal, shipping, tax),
          SizedBox(height: SizeConfig.getProportionateScreenHeight(16)),

          // Divider
          Divider(
            color: Colors.grey[300],
            thickness: 1,
          ),
          SizedBox(height: SizeConfig.getProportionateScreenHeight(16)),

          // Total
          _buildTotalSection(total),
          SizedBox(height: SizeConfig.getProportionateScreenHeight(20)),

          // Checkout Button
          _buildCheckoutButton(),
          SizedBox(height: SizeConfig.getProportionateScreenHeight(8)),

          // Security Badge
          _buildSecurityBadge(),
        ],
      ),
    );
  }

  Widget _buildCouponSection() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.getProportionateScreenWidth(12),
        vertical: SizeConfig.getProportionateScreenHeight(8),
      ),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(
            Icons.local_offer_outlined,
            color: Colors.blue,
            size: SizeConfig.getProportionateScreenWidth(18),
          ),
          SizedBox(width: SizeConfig.getProportionateScreenWidth(8)),
          Expanded(
            child: Text(
              'Have a coupon code?',
              style: TextStyle(
                fontSize: SizeConfig.getProportionateScreenWidth(14),
                color: Colors.blue[800],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          GestureDetector(
            onTap: onApplyCoupon,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.getProportionateScreenWidth(12),
                vertical: SizeConfig.getProportionateScreenHeight(6),
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                'Apply',
                style: TextStyle(
                  fontSize: SizeConfig.getProportionateScreenWidth(12),
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceBreakdown(double subtotal, double shipping, double tax) {
    return Column(
      children: [
        _buildPriceRow('Subtotal', _formatCurrency(subtotal)),
        SizedBox(height: SizeConfig.getProportionateScreenHeight(8)),
        _buildPriceRow('Shipping', _formatCurrency(shipping)),
        SizedBox(height: SizeConfig.getProportionateScreenHeight(8)),
        _buildPriceRow('Tax', _formatCurrency(tax)),
      ],
    );
  }

  Widget _buildPriceRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: SizeConfig.getProportionateScreenWidth(14),
            color: Colors.grey[600],
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: SizeConfig.getProportionateScreenWidth(14),
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }

  Widget _buildTotalSection(double total) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Total',
          style: TextStyle(
            fontSize: SizeConfig.getProportionateScreenWidth(18),
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          _formatCurrency(total),
          style: TextStyle(
            fontSize: SizeConfig.getProportionateScreenWidth(20),
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
      ],
    );
  }

  Widget _buildCheckoutButton() {
    return Container(
      width: double.infinity,
      height: SizeConfig.getProportionateScreenHeight(56),
      child: ElevatedButton(
        onPressed: onCheckout,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.lock_outline,
              color: Colors.white,
              size: SizeConfig.getProportionateScreenWidth(18),
            ),
            SizedBox(width: SizeConfig.getProportionateScreenWidth(8)),
            Text(
              'Proceed to Checkout',
              style: TextStyle(
                fontSize: SizeConfig.getProportionateScreenWidth(16),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSecurityBadge() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.security,
          color: Colors.green,
          size: SizeConfig.getProportionateScreenWidth(14),
        ),
        SizedBox(width: SizeConfig.getProportionateScreenWidth(4)),
        Text(
          'Secure checkout · 256-bit SSL encryption',
          style: TextStyle(
            fontSize: SizeConfig.getProportionateScreenWidth(12),
            color: Colors.grey[500],
          ),
        ),
      ],
    );
  }

  String _formatCurrency(double amount) {
    return '\$${amount.toStringAsFixed(2)}';
  }
}