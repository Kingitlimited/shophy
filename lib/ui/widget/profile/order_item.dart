// lib/ui/widgets/profile/order_item.dart
import 'package:flutter/material.dart';
import '../../../utils/size_config.dart';

class OrderItem extends StatelessWidget {
  final String orderId;
  final String date;
  final String status;
  final String total;
  final int itemCount;
  final VoidCallback onTap;

  const OrderItem({
    Key? key,
    required this.orderId,
    required this.date,
    required this.status,
    required this.total,
    required this.itemCount,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Order #$orderId',
                style: TextStyle(
                  fontSize: SizeConfig.getProportionateScreenWidth(16),
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.getProportionateScreenWidth(8),
                  vertical: SizeConfig.getProportionateScreenHeight(4),
                ),
                decoration: BoxDecoration(
                  color: _getStatusColor(status).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: SizeConfig.getProportionateScreenWidth(12),
                    fontWeight: FontWeight.w600,
                    color: _getStatusColor(status),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: SizeConfig.getProportionateScreenHeight(8)),
          Text(
            'Placed on $date',
            style: TextStyle(
              fontSize: SizeConfig.getProportionateScreenWidth(14),
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: SizeConfig.getProportionateScreenHeight(8)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$itemCount item${itemCount > 1 ? 's' : ''}',
                style: TextStyle(
                  fontSize: SizeConfig.getProportionateScreenWidth(14),
                  color: Colors.grey[600],
                ),
              ),
              Text(
                total,
                style: TextStyle(
                  fontSize: SizeConfig.getProportionateScreenWidth(16),
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          SizedBox(height: SizeConfig.getProportionateScreenHeight(12)),
          Container(
            height: SizeConfig.getProportionateScreenHeight(40),
            child: OutlinedButton(
              onPressed: onTap,
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                side: BorderSide(color: Colors.blue),
              ),
              child: Text(
                'View Details',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: SizeConfig.getProportionateScreenWidth(14),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'delivered':
        return Colors.green;
      case 'processing':
        return Colors.orange;
      case 'shipped':
        return Colors.blue;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}